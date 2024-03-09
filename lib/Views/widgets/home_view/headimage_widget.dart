import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeadImageWidget extends StatelessWidget {
  final String url, title;
  const HeadImageWidget({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flexible(
        flex: 1,
        child: Center(
          child: Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.low,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Image.asset(
                                "assets/images/dhakaprokash_logo.png",
                              ),
                            ),
                )

                /* Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                )*/
                ),
          ),
        ),
      ),
      SizedBox(
          child: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.start,
      ))
    ]);
  }
}
