import 'dart:math';
import 'package:flutter/material.dart';
import 'package:viewcast/components/controlled_animation.dart';
import 'package:viewcast/styles.dart';

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;
  final Color color;

  const AnimatedWave({
    Key? key,
    required this.height,
    required this.speed,
    required this.offset,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: ControlledAnimation(
            playback: Playback.loop,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                  foregroundPainter: CurvePainter(
                      double.parse(value.toString()) + offset, color));
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;
  final Color color;

  CurvePainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = color;
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WaveBackground extends StatelessWidget {
  const WaveBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = 0.6;
    double speed = 0.05 / 2;

    return SizedBox(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedWave(
              height: 400 * ratio,
              speed: speed,
              offset: 33,
              color: fakeViewCastColor.withAlpha(120)),
          AnimatedWave(
              height: 350 * ratio,
              speed: speed,
              offset: 67,
              color: fakeViewCastColor.withAlpha(120)),
          AnimatedWave(
              height: 380 * ratio,
              speed: speed,
              offset: 44,
              color: fakeViewCastColor.withAlpha(120)),
        ],
      ),
    );
  }
}
