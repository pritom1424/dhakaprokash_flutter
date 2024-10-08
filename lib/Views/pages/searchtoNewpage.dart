import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';

import 'package:dummy_app/Models/search_model.dart';
import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_search.dart';

import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchToNewPage extends StatefulWidget {
  const SearchToNewPage({super.key});

  @override
  State<SearchToNewPage> createState() => _SearchToNewPageState();
}

class _SearchToNewPageState extends State<SearchToNewPage> {
  List<DhakaprokashSearchModel> currentSearchItems = [];
  TextEditingController textEditingController = TextEditingController();

  bool didShowList = false;
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  bool didGlow = false;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  void dispose() {
    currentSearchItems.clear();
    textEditingController.dispose();
    didShowList = false;
    GenericVars.currentSearchString = "";
    // TODO: implement dispose
    super.dispose();
  }

  void _listen() async {
    didGlow = !didGlow;
    Timer speechTimer;
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      var locals = await _speech!.locales();
      for (var element in locals) {
        print("speech locals: ${element.name}");
      }
      if (available) {
        speechTimer = Timer(const Duration(seconds: 5), () {
          setState(() {
            _isListening = false;
            didGlow = false;
          });
        });
        //_isListening = true;
        setState(() => _isListening = true);

        _speech!.listen(
            listenOptions:
                stt.SpeechListenOptions(listenMode: stt.ListenMode.search),
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;

                  didShowList = true;
                  _isListening = false;
                  didGlow = false;
                  GenericVars.currentSearchString = _text;
                  textEditingController.clear();
                  textEditingController.text = _text;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _confidence = val.confidence;
                  }
                }));
      }
    } else {
      setState(() => _isListening = false);

      _speech!.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) => Scaffold(
          appBar: AppBar(
            title: Container(
                height: GenericVars.scSize.height * 0.1,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.grey))),
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      onSubmitted: (value) {
                        didShowList = true;
                        textEditingController.text =
                            textEditingController.text.trim();
                        GenericVars.currentSearchString =
                            textEditingController.text;
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        setState(() {});
                      },
                      controller: textEditingController,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 105, 102, 102)),
                      /*   onChanged: (value) {
                        textEditingController.clear();
                        textEditingController.text = value;
                      }, */
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          hintText: "অনুসন্ধান করুন...",
                          suffixIcon: AvatarGlow(
                            glowRadiusFactor: 0.1,
                            animate: _isListening,
                            glowColor: (didGlow)
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            duration: const Duration(milliseconds: 2000),
                            // repeatPauseDuration: const Duration(milliseconds: 100),
                            repeat: true,
                            child: IconButton(
                              onPressed: _listen,
                              icon: Icon(
                                  _isListening ? Icons.mic : Icons.mic_none),
                            ),
                          ),
                          prefixIcon: IconButton(
                              onPressed: () {
                                didShowList = true;
                                textEditingController.text =
                                    textEditingController.text.trim();
                                GenericVars.currentSearchString =
                                    textEditingController.text;
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                setState(() {});
                                /* Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SearchToNewPage(
                                        textEditingController.text))); */
                              },
                              icon: const Icon(Icons.search)),
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                    ))),
            /*   Text(
              widget.searchString.toLowerCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ), */
          ),
          body: (didShowList)
              ? FutureBuilder(
                  future: ref.watch(searchController).loadAllRegSearchItemsPost(
                      GenericVars.currentSearchString, 10),
                  builder: (ctx, postSnapShot) {
                    currentSearchItems = postSnapShot.data ?? [];
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const LoaderWidget()
                        : (currentSearchItems.isNotEmpty
                            ? SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CategoryWidgetSearch(
                                      dhakaprokashModels: postSnapShot.data!,
                                      categoryName: "Search",
                                      didMoreButtonShow: false,
                                      didHeadSectionShow: false,
                                      listItemLength: postSnapShot.data!.length,
                                      didFloat: false),
                                ),
                              )
                            : const Center(
                                child: Text(
                                "কিছু পাওয়া যায়নি",
                                //  style: Theme.of(context).textTheme.bodyLarge,
                              )));
                  })
              : const SizedBox.shrink()),
    );
  }
}
