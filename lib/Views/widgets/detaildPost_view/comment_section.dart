import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentSectionWidget extends StatefulWidget {
  const CommentSectionWidget({super.key});

  @override
  State<CommentSectionWidget> createState() => _CommentSectionWidgetState();
}

class _CommentSectionWidgetState extends State<CommentSectionWidget> {
  String dropDownValue = "0";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: GenericVars.scSize.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Text(
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    underline: SizedBox.shrink(),
                    value: dropDownValue,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    onTap: () {},
                    items: const [
                      DropdownMenuItem(
                        child: Text(
                          "Newest",
                        ),
                        value: "0",
                      ),
                      DropdownMenuItem(
                        child: Text("Oldest"),
                        value: "1",
                      )
                    ],
                    onChanged: (val) {
                      setState(() {
                        dropDownValue = val!;
                      });
                    }),
              ),
              Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share),
                label: Text("Share"),
              )
            ],
          ),
          Container(
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
                padding: EdgeInsets.all(0),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.3, color: Colors.black87),
                    borderRadius: BorderRadius.circular(5)),
                fixedSize: Size(GenericVars.scSize.width * 0.2,
                    GenericVars.scSize.height * 0.05),
              ),
              onPressed: () {},
              icon: Icon(Icons.play_arrow),
              label: Text(
                "POST",
                style: TextStyle(fontSize: 13),
              ))
        ],
      ),
    );
  }
}
