import 'package:cpsales/core/constants.dart';
import 'package:cpsales/core/extensions/margin_ext.dart';
import 'package:cpsales/shared/utils/colors.dart';
import 'package:cpsales/shared/widgets/app_btn.dart';
import 'package:cpsales/shared/widgets/app_svg.dart';
import 'package:cpsales/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/screen_utils.dart';

class AppWarningSheet extends StatelessWidget {
  const AppWarningSheet({super.key,  required this.alertMessage,  this.onTap});

 
  final String alertMessage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: alertBgClr,
                  child: AppSvg(assetName: "alert"),
                ),
                14.wBox,
                 const AppText(
                  "Attention Please!",
                  size: 16,
                  family: inter600,
                )
              ],
            ),
            16.hBox,
            RichText(
                text:  TextSpan(
              children: [
                const TextSpan(
                  text: 'Note: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: inter600,
                    color: primaryGreyClr,
                  ),
                ),
                TextSpan(
                  text:
                     alertMessage,
                  style: const TextStyle(
                      fontSize: 14,
                      color: primaryGreyClr,
                      fontFamily: inter400),
                ),
              ],
            )),
            24.hBox,
            AppButton(
              text: "Yes, Now",
              minHeight: 44,
              onPressed: onTap,
              ),
            
            12.hBox,
            AppButton(
                text: "Cancel",
                minHeight: 44,
                isFilledBtn: false,
                btnClr: gray700Clr,
                borderSideClr: inputBorderClr,
                onPressed: () => Screen.closeDialog()),
          ],
        ),
      ),
    );
  }
}
