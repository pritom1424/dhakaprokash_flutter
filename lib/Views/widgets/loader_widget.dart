import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.blue, // Color of the spinner
        size: 50.0,
        duration: Duration(milliseconds: 1500), // Size of the spinner
      ),
    );
  }
}
