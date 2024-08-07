import 'package:flutter/material.dart';

import '../../core/screen_utils.dart';
import '../../shared/utils/colors.dart';

class AppbarBack extends StatelessWidget implements PreferredSizeWidget {
  const AppbarBack({
    super.key,
    required this.title,
    this.isShowCloseIcon = false,
    this.onSaveTapped,
   
    this.actions, this.isClose=false, this.isCenterTitle=false,
  });

  final String? title;
  final bool isShowCloseIcon;
  final void Function()? onSaveTapped;
  final List<Widget>? actions;
  final bool isClose,isCenterTitle;
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      title: Text(title ?? ""),
      leading: IconButton(
        icon: Icon(isShowCloseIcon ? Icons.close : Icons.keyboard_arrow_left_rounded),
        onPressed: () => Screen.close(),
      ),
      actions: actions ??
          [
            if (onSaveTapped != null)
              IconButton(
                  onPressed: onSaveTapped,
                  icon: const Icon(Icons.check_circle_outline_rounded, color: success700Clr, size: 28)),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
