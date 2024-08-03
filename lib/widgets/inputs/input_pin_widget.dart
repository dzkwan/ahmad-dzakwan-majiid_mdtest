import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class InputPINWidget extends StatelessWidget {
  InputPINWidget({super.key, required this.value});
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 65,
      decoration: BoxDecoration(
        color: LightColors.border,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: LightColors.white.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: Center(
        child: TextBigBold(value: value, color: LightColors.mainText),
      ),
    );
  }
}
