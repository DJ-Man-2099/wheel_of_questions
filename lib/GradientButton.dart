import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color splashColor;
  final LinearGradient gradient;

  GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.splashColor = const Color(0xFFFAFAFA),
    this.gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Ink(
        decoration: ShapeDecoration(
          gradient: gradient,
          shape: StadiumBorder(),
        ),
        child: Container(
          height: 50,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: splashColor,
        padding: EdgeInsets.zero,
        shape: StadiumBorder(),
      ),
    );
  }
}
