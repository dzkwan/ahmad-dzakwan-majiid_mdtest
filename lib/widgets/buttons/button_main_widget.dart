import 'package:fan_test/themes/light_colors.dart';
import 'package:flutter/material.dart';

class ButtonMainWidget extends StatelessWidget {
  ButtonMainWidget({
    Key? key,
    required this.text,
    this.isEnable = true,
    BoxBorder? border,
    this.onTap,
    this.backgroundColor = LightColors.mainColor,
  })  : border = border ??
            Border.all(
                color: isEnable
                    ? backgroundColor
                    : backgroundColor.withOpacity(0.1)),
        super(key: key);
  Widget text;
  bool isEnable;
  BoxBorder? border;
  Function()? onTap;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isEnable ? backgroundColor : backgroundColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: !isEnable ? Colors.transparent : null,
          highlightColor: !isEnable ? Colors.transparent : null,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: isEnable ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: text,
            ),
          ),
        ),
      ),
    );
  }
}
