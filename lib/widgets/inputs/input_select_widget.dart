import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/constants_helper.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class InputSelectWidget extends StatelessWidget {
  InputSelectWidget({
    super.key,
    this.title,
    this.placeHolder = "",
    this.value = "",
    this.prefix,
    this.suffix,
    this.onTap,
    this.iconMandatory = false,
    this.isEnable = true,
    this.isSizeSmall = false,
    this.borderColor = LightColors.gray,
  });

  String? title;
  String placeHolder;
  String value;
  Widget? prefix;
  Widget? suffix;
  Color borderColor;
  VoidCallback? onTap;
  bool iconMandatory;
  bool isEnable;
  bool isSizeSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            children: [
              TextNormalRegular(
                value: title,
                color: LightColors.mainText,
              ),
              if (iconMandatory) ...[
                TextNormalRegular(
                  value: "*",
                  color: LightColors.red,
                ),
              ]
            ],
          ),
          SizedBox(height: 4),
        ],
        Container(
          decoration: BoxDecoration(
            color: isEnable ? LightColors.white : LightColors.disable,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: isEnable ? onTap : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: isSizeSmall ? 6 : 10, horizontal: 11),
                width: ConstantsHelper.screenWidth,
                child: SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: prefix != null ? 5 : 0),
                        child: prefix ?? SizedBox.shrink(),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            value == "" ? placeHolder : value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: value == ""
                                  ? LightColors.notSelected
                                  : LightColors.mainText,
                            ),
                          ),
                        ),
                      ),
                      suffix ?? SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
