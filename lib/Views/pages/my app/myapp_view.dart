import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarDefault(),
        body: Container(
          height: GenericVars.scSize.height,
          width: GenericVars.scSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(width: 1, color: Colors.grey))),
                height: GenericVars.scSize.height * 0.15,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CircleAvatar(
                        child: Image.asset(
                            "assets/images/character_placeholder.png"),
                        radius: 40,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Terms of use",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text("Privacy policy",
                          style: Theme.of(context).textTheme.headlineMedium))
                ],
              )
            ],
          ),
        ));
  }
}
