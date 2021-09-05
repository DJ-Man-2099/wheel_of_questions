import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget child;
  final Color splashColor;
  final LinearGradient gradient;

  GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.splashColor = const Color.fromARGB(100, 10, 10, 10),
    this.gradient = const LinearGradient(colors: [Colors.red, Colors.blue]),
  }) : super(key: key);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  double height = 50, width = 300, elevation = 2;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: height,
      width: width,
      child: Card(
        elevation: elevation,
        shape: StadiumBorder(),
        child: InkWell(
          splashColor: widget.splashColor,
          onHover: (bool flag) {
            if (flag) {
              setState(() {
                height = 55;
                width = 350;
                elevation = 5;
              });
            } else {
              setState(() {
                height = 50;
                elevation = 2;
                width = 300;
              });
            }
          },
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Ink(
            decoration: ShapeDecoration(
              gradient: widget.gradient,
              shape: StadiumBorder(),
            ),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}
