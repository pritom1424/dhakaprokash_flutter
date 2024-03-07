import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeadImageWidget extends StatelessWidget {
  final String url, title;
  const HeadImageWidget({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        Flexible(
          flex: 2,
          child: Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                )),
          ),
        ),
        Flexible(
            flex: 1,
            child: SizedBox(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.start,
              ),
            )))
      ]),
    );
  }
}
