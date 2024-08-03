import 'package:fan_test/themes/light_colors.dart';
import 'package:flutter/material.dart';

class SearchPainter extends CustomPainter {
  final Offset? center;
  final double? radius, containerHeight;
  final BuildContext? context;

  Color? color;
  double? statusBarHeight, screenWidth;

  SearchPainter({this.context, this.containerHeight, this.center, this.radius}) {

    color = LightColors.white;
    statusBarHeight = MediaQuery.of(context!).padding.top;
    screenWidth = MediaQuery.of(context!).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();

    circlePainter.color = color!;
    canvas.clipRect(Rect.fromLTWH(0, 0, screenWidth!, containerHeight! + statusBarHeight!));
    canvas.drawCircle(center!, radius!, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}