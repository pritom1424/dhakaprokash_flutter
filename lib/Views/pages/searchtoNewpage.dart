import 'package:avatar_glow/avatar_glow.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchToNewPage extends StatefulWidget {
  SearchToNewPage({super.key});

  @override
  State<SearchToNewPage> createState() => _SearchToNewPageState();
}

class _SearchToNewPageState extends State<SearchToNewPage> {
  List<PhotoModel> currentSearchItems = [];
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

    // TODO: implement initState
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
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      var locals = await _speech!.locales();
      locals.forEach((element) {
        print(element.name);
      });
      if (available) {
        //_isListening = true;
        setState(() => _isListening = true);

        _speech!.listen(
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
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
              height: GenericVars.scSize.height * 0.1,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.grey))),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
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
                        hintText: "Search...",
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
                            icon:
                                Icon(_isListening ? Icons.mic : Icons.mic_none),
                          ),
                        ),
                        prefixIcon: IconButton(
                            onPressed: () {
                              didShowList = true;
                              // Navigator.of(context).pop();
                              // Focus.of(context).unfocus();
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
                            icon: Icon(Icons.search)),
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
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
                future: photoController.loadSearchAllItems(
                    GenericVars.currentSearchString.toLowerCase()),
                builder: (ctx, photosnapShot) =>
                    (photosnapShot.connectionState == ConnectionState.waiting)
                        ? const LoaderWidget()
                        : FutureBuilder(
                            future: postController.loadAllItems(),
                            builder: (ctx, postSnapShot) {
                              currentSearchItems = photoController.SearchItems;
                              return (postSnapShot.connectionState ==
                                      ConnectionState.waiting)
                                  ? const LoaderWidget()
                                  : (currentSearchItems.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: CategoryWidget(
                                                photoModels:
                                                    photoController.SearchItems,
                                                postModels:
                                                    postController.Items,
                                                categoryName: "Search",
                                                didMoreButtonShow: false,
                                                didHeadSectionShow: false,
                                                listItemLength: 8,
                                                didFloat: false),
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                          "Not Found",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )));
                            }))
            : Container());
  }
}
