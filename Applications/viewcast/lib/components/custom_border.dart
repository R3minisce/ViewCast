import 'package:flutter/material.dart';

BoxDecoration shadowBorder(double leftRadius, double rightRadius, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.horizontal(
        left: Radius.circular(leftRadius), right: Radius.circular(rightRadius)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}

class CustomGradient extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Widget child;

  const CustomGradient({
    Key? key,
    required this.color1,
    required this.color2,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(colors: [
              color1,
              color2,
            ]).createShader(
              Rect.fromLTWH(1, 0, bounds.width, bounds.height),
            ),
        child: child);
  }
}
