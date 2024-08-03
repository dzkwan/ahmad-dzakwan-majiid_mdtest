import 'package:flutter/material.dart';

// Big
Widget CustomText({
  String? value,
  Color? color,
  double size = 14,
  double letterSpacing = 0,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w400,
  TextOverflow textOverflow = TextOverflow.ellipsis,
  int maxLines = 1,
}) {
  return Text(
    value!,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: textOverflow,
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing),
  );
}

// Big
Widget TextBigBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing),
  );
}

Widget TextBigSemiBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: letterSpacing),
  );
}

// Medium
Widget TextMediumRegular(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing),
  );
}

Widget TextMediumBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing),
  );
}

Widget TextMediumSemiBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: letterSpacing),
  );
}

// Normal
Widget TextNormalRegular(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    double height = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height),
  );
}

Widget TextNormalSemiBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing),
  );
}

Widget TextNormalBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing),
  );
}

// Small
Widget TextSmallRegular(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing),
  );
}

Widget TextSmallSemiBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: letterSpacing),
  );
}

Widget TextSmallBold(
    {String? value,
    Color? color,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    value!,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing),
  );
}
