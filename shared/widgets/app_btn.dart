import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../utils/colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.icon,
      this.isExpand = true,
      this.isRounded = true,
      this.isFilledBtn = true,
      this.minHeight,
      this.borderSideClr,
      this.btnClr = primaryClr});

  final void Function()? onPressed;
  final String text;
  final Color btnClr;
  final Color? borderSideClr;
  final Widget? icon;
  final bool isExpand, isRounded, isFilledBtn;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      height: minHeight,
      child: icon == null
          ? TextButton(
              onPressed: onPressed,
              style: _buildStyle(),
              child: ButtonText(text: text, btnClr: btnClr, isFilledBtn: isFilledBtn),
            )
          : TextButton.icon(
              onPressed: onPressed,
              style: _buildStyle(),
              icon: icon!,
              label: ButtonText(text: text, btnClr: btnClr, isFilledBtn: isFilledBtn),
            ),
    );
  }

  ButtonStyle _buildStyle() {
    return TextButton.styleFrom(
        elevation: isFilledBtn ? 4 : 0,
        shadowColor: isFilledBtn ? btnClr : null,
        iconColor: Colors.white,
        padding: minHeight == null ? EdgeInsets.symmetric(horizontal: 16, vertical: isExpand ? 14 : 14) : null,
        backgroundColor: isFilledBtn ? btnClr : null,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderSideClr ?? btnClr),
            borderRadius: BorderRadius.all(Radius.circular(isRounded ? 8 : 0))));
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.text,
    required this.btnClr,
    required this.isFilledBtn,
  });

  final String text;
  final Color btnClr;
  final bool isFilledBtn;

  @override
  Widget build(BuildContext context) {
    return AppText(text, family: inter600, color: isFilledBtn ? Colors.white : btnClr);
  }
}
