import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class PostTagTile extends StatelessWidget {
  const PostTagTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GenericVars.scSize.height * 0.2,
      width: double.infinity,
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 7 / 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 5,
          children: List.generate(
              5,
              (index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 193, 222, 235),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 193, 222, 235))),
                      child: TextButton(onPressed: () {}, child: Text("tag")),
                    ),
                  ))),
    );
  }
}
