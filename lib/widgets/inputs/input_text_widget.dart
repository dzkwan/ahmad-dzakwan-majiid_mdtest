import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {
  InputTextWidget({
    super.key,
    this.title,
    this.onChanged,
    this.textInputAction,
    this.onEditingComplete,
    this.controller,
    this.hintText,
    this.textInputType = TextInputType.emailAddress,
    this.isPassword = false,
    this.enable = true,
    this.maxLines,
  });
  Function(String)? onChanged;
  VoidCallback? onEditingComplete;
  String? title;
  bool isPassword;
  String? hintText;
  int? maxLines;
  bool enable;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  TextInputType textInputType;

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool hideText = true;

  showText() {
    setState(() {
      hideText = !hideText;
    });
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          TextNormalRegular(
            value: widget.title,
            color: LightColors.mainText,
          ),
          const SizedBox(height: 4),
        ],
        TextFormField(
          controller: widget.controller,
          style: const TextStyle(color: LightColors.mainText),
          cursorColor: LightColors.mainText,
          keyboardType: widget.textInputType,
          obscureText: widget.isPassword == true ? hideText : false,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          maxLines: widget.isPassword == true ? 1 : widget.maxLines,
          minLines: widget.isPassword == true ? null : 1,
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hintText,
            focusColor: LightColors.mainText,
            fillColor: LightColors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
            labelStyle: const TextStyle(
              color: LightColors.notSelected,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LightColors.notSelected,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LightColors.notSelected,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LightColors.notSelected,
                // width: 2,
              ),
            ),
            suffixIconColor: LightColors.mainColor,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: showText,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(hideText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
