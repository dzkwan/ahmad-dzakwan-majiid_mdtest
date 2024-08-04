import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  final r = random.nextInt(256);
  final g = random.nextInt(256);
  final b = random.nextInt(256);
  const threshold = 190;
  if (r < threshold || g < threshold || b < threshold) {
    return getRandomColor();
  }
  return Color.fromARGB(255, r, g, b);
}
