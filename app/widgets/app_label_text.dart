import '../../core/constants.dart';
import '../../core/extensions/string_ext.dart';
import 'package:flutter/material.dart';

import '../../shared/utils/colors.dart';
import '../../shared/widgets/app_text.dart';

class AppLabelText extends StatelessWidget {
  const AppLabelText({
    super.key,
    required this.text,
    this.txtClr,
  });

  final String text;
  final Color? txtClr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppText(text.upperFirst,
          family: inter500, color: txtClr ?? inputLabelClr),
    );
  }
}
