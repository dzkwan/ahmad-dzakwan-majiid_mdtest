import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/buttons/button_main_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class DialogWidget extends StatelessWidget {
  DialogWidget({
    Key? key,
    required this.title,
    this.okeBtn,
    this.okeTitle = "OKE",
    this.cancelTitle = "BATAL",
    this.value,
    this.valueCustom,
    this.cancelBtn,
  });

  String title;
  String? value;
  Widget? valueCustom;
  String? okeTitle;
  String? cancelTitle;
  VoidCallback? okeBtn;
  VoidCallback? cancelBtn;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      insetPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: LightColors.white,
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBigBold(value: title),
            const SizedBox(height: 16),
            if (value != null) ...[
              TextNormalRegular(
                value: value,
                height: 1.5,
                textAlign: TextAlign.center,
              ),
            ] else if (valueCustom != null) ...[
              valueCustom!
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cancelBtn != null) ...[
                  TextButton(
                    onPressed: cancelBtn,
                    child: TextNormalBold(
                      value: cancelTitle ?? "",
                      color: LightColors.mainColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
                if (okeBtn != null)
                  TextButton(
                    onPressed: okeBtn,
                    child: TextNormalBold(
                      value: okeTitle ?? "",
                      color: LightColors.mainColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Dialog2Widget extends StatelessWidget {
  String? title;
  String? value;
  Widget? valueCustom;
  Callback okeBtn;
  String? okeTitle;
  Callback? cancelBtn;
  String? cancelTitle;

  Dialog2Widget({
    Key? key,
    this.title,
    this.value,
    this.valueCustom,
    required this.okeBtn,
    this.cancelBtn,
    this.okeTitle = "OKE",
    this.cancelTitle = "BATAL",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      insetPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: LightColors.white,
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              TextBigBold(
                value: title,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            if (value != null) ...[
              TextNormalRegular(
                value: value,
                height: 1.5,
                textAlign: TextAlign.center,
              ),
            ] else if (valueCustom != null) ...[
              valueCustom!
            ],
            const SizedBox(height: 36),
            Row(
              children: [
                if (cancelBtn != null) ...[
                  Expanded(
                    child: ButtonMainWidget(
                      backgroundColor: Colors.transparent,
                      text: TextNormalBold(
                        value: cancelTitle,
                        color: LightColors.mainColor,
                        letterSpacing: 1.25,
                      ),
                      border: Border.all(
                        color: LightColors.mainColor,
                      ),
                      onTap: cancelBtn,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: ButtonMainWidget(
                    text: TextNormalBold(
                      value: okeTitle,
                      color: LightColors.white,
                      letterSpacing: 1.25,
                    ),
                    onTap: okeBtn,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
