import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants.dart';
import '../../core/extensions/margin_ext.dart';
import '../utils/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.hint,
      this.maxLines,
      this.controller,
      this.isOutlineBorder = true,
      this.labelText,
      this.prefixIcon,
      this.hintColor = inputHintClr,
      this.bgColor,
      this.borderClr = inputBorderClr,
      this.style,
      this.textFieldHeight,
      this.borderRadius,
      this.suffixText,
      this.suffixIcon,
      this.suffixStyle,
      this.onChanged,
      this.focusNode,
      this.readOnly = false,
      this.disabled = false,
      this.isCapitalNot = false,
      this.obscureText = false,
      this.onTap,
      this.isRequired = false,
      this.keyboardType,
      this.textAlign,
      this.textInputAction = TextInputAction.next,
      this.validator,
      this.child,
      this.isDropDown = false,
      this.helperText});

  final String? hint, labelText, suffixText, helperText;
  final TextEditingController? controller;
  final bool isOutlineBorder, obscureText, isCapitalNot;
  final int? maxLines;
  final Color? bgColor, borderClr, hintColor;
  final Widget? prefixIcon, suffixIcon;
  final TextStyle? style, suffixStyle;
  final double? borderRadius, textFieldHeight;
  final FocusNode? focusNode;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  final bool readOnly, disabled, isDropDown, isRequired;

  final TextAlign? textAlign;
  final TextInputAction textInputAction;
  final String? Function(String? value)? validator;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return onTap != null || isDropDown
        ? InkWell(
            onTap: disabled ? null : onTap,
            child: IgnorePointer(ignoring: true, child: buildBtn()))
        : buildBtn();
  }

  Widget buildBtn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText?.isNotEmpty == true) 8.hBox,
        if (labelText?.isNotEmpty == true)
          // AppText(labelText, family: inter500, color: inputLabelClr),
          Text.rich(
            TextSpan(
              text: labelText,
              children: isRequired
                  ? <InlineSpan>[
                      const TextSpan(
                        text: ' *',
                        style:
                            TextStyle(color: Colors.red, fontFamily: inter500),
                      )
                    ]
                  : null,
              style: const TextStyle(
                  fontFamily: inter500, color: inputLabelClr, fontSize: 14),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: child ??
              TextFormField(
                focusNode: focusNode,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      keyboardType == TextInputType.phone ||
                              keyboardType == TextInputType.number
                          ? 10
                          : (maxLines == null ? 50 : 300)),
                ],
                textCapitalization: isCapitalNot
                    ? TextCapitalization.none
                    : TextCapitalization.sentences,
                validator: validator,
                controller: controller,
                maxLines: obscureText ? 1 : maxLines ?? 1,
                style: const TextStyle(fontSize: 14, fontFamily: inter400),
                onChanged: onChanged,
                enabled: true,
                keyboardType: keyboardType,
                readOnly: onTap != null ? true : (readOnly || disabled),
                textAlign: textAlign ?? TextAlign.start,
                cursorColor: Colors.black,
                obscureText: obscureText,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                    fillColor:
                        disabled ? Colors.grey.withOpacity(0.15) : bgColor,
                    helperText: helperText,
                    helperMaxLines: 2,
                    helperStyle: const TextStyle(
                      fontSize: 11,
                      color: inputHintClr,
                    ),
                    filled: disabled || (bgColor == null ? false : true),
                    hintText: hint,
                    suffixText: suffixText,
                    suffixStyle: suffixStyle,
                    prefixIcon: prefixIcon != null
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: prefixIcon)
                        : null,
                    suffixIcon: isDropDown
                        ? const Icon(Icons.keyboard_arrow_down_rounded)
                        : suffixIcon,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: _setBorder(
                        borderClr: borderClr, borderRadius: borderRadius),
                    enabledBorder: _setBorder(
                        borderClr: borderClr, borderRadius: borderRadius),
                    focusedBorder: _setBorder(
                        borderClr: borderClr, borderRadius: borderRadius),
                    errorBorder: _setBorder(
                        borderClr: Colors.redAccent,
                        borderRadius: borderRadius),
                    focusedErrorBorder: _setBorder(
                        borderClr: Colors.redAccent,
                        borderRadius: borderRadius),
                    errorStyle:
                        const TextStyle(fontFamily: inter500, fontSize: 11),
                    hintStyle: TextStyle(
                        fontFamily: inter400, fontSize: 12, color: hintColor),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: ((maxLines ?? 1) > 1) ? 16 : 2)),
              ),
        ),
      ],
    );
  }

  InputBorder? _setBorder({Color? borderClr, double? borderRadius}) {
    return borderClr == null
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(color: borderClr),
            borderRadius: BorderRadius.circular(borderRadius ?? 9));
  }
}
