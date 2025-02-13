import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/screen_utils.dart';
import '../../shared/utils/colors.dart';
import '../../shared/widgets/app_lottie.dart';
import '../../shared/widgets/app_text.dart';

class AppSuccessBottomSheet extends StatelessWidget {
  const AppSuccessBottomSheet({super.key, required this.successText});

  final String successText;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Screen.closeDialog();
    });
    return ListView(
      shrinkWrap: true,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     GestureDetector(
        //         onTap: () => Screen.closeDialog(),
        //         child: const Icon(Icons.close))
        //   ],
        // ),
        const AppLottie(
          assetName: "verified",
          width: 100,
          height: 100,
        ),
        Center(
          child: AppText(
            successText,
            size: 16,
            color: primaryClr,
            family: inter600,
          ),
        ),
      ],
    );
  }
}
