import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/constants_helper.dart';
import 'package:flutter/material.dart';

class ButtonPINWidget extends StatelessWidget {
  ButtonPINWidget({
    super.key,
    required this.value,
    this.borderColor = LightColors.mainColor,
    this.bgColor = LightColors.white,
    this.onTap,
  });
  Widget value;
  Color borderColor;
  Color bgColor;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: LightColors.white.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: SizedBox(
            width: ConstantsHelper.screenWidth * 0.2,
            height: 50,
            child: Center(child: value),
          ),
        ),
      ),
    );
  }
}
