import 'package:flutter/material.dart';

class DeskView extends StatelessWidget {
  const DeskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Dhaka prokash Desk',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
