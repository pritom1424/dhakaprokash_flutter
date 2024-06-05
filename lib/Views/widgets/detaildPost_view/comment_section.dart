import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentSectionWidget extends StatefulWidget {
  const CommentSectionWidget({super.key});

  @override
  State<CommentSectionWidget> createState() => _CommentSectionWidgetState();
}

class _CommentSectionWidgetState extends State<CommentSectionWidget> {
  String dropDownValue = "0";
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, _) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                )),
            Row(
              children: [
                Container(
                  height: GenericVars.scSize.height * 0.04,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.3),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      menuMaxHeight: GenericVars.scSize.height * 0.15,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      underline: const SizedBox.shrink(),
                      value: dropDownValue,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onTap: () {},
                      items: const [
                        DropdownMenuItem(
                          value: "0",
                          child: Text(
                            "Newest",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "1",
                          child: Text("Oldest"),
                        )
                      ],
                      onChanged: (val) {
                        setState(() {
                          dropDownValue = val!;
                        });
                      }),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                )
              ],
            ),
            SizedBox(
              height: GenericVars.scSize.height * 0.05,
              child: const TextField(
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                    border: OutlineInputBorder(),
                    hintText: "Share your thoughts...",
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Helvetica")),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.3, color: Colors.black87),
                      borderRadius: BorderRadius.circular(5)),
                  fixedSize: Size(GenericVars.scSize.width * 0.2,
                      GenericVars.scSize.height * 0.05),
                ),
                onPressed: () {
                  ref.watch(detailPageController).notCommentClick();
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  "POST",
                  style: TextStyle(fontSize: 13),
                ))
          ],
        ),
      );
    });
  }
}
