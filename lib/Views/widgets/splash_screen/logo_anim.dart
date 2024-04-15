import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  State<LogoAnimation> createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.ease);
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        height: GenericVars.scSize.height * 0.06,
        child: Image.asset("assets/images/dhakaprokash_icon.png"),
      ),
    );
  }

  /* RotationTransition(
      turns: _animation,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image.asset("assets/images/dhakaprokash_icon.png"),
      ),
    ); */

  /*
    Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_controller.value * 5 * 3.14159),
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/dhakaprokash_icon.png")),
            );
          }),
    );
    
    
     */
}
