import 'package:flutter/material.dart';

import '../../shared/widgets/app_text.dart';

class AppErrorText extends StatelessWidget {
  const AppErrorText({
    super.key,
    this.title,
    this.message,
    this.vPadding = 62,
    this.hPadding = 32,
  });

  final String? title;
  final String? message;
  final double vPadding, hPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.01),
        // border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
        // borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        child: AppText(
            message ?? "No $title's found!, inform admin to add and try again.",
            color: Colors.redAccent,
            align: TextAlign.center),
      ),
    );
  }
}
