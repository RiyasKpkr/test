
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '../../core/screen_utils.dart';
import '../../shared/utils/colors.dart';
import '../../shared/widgets/app_text.dart';
import '../../shared/widgets/app_text_field.dart';
import '../model/prd_category.dart';
import '../model/product.dart';
import 'app_error_text.dart';

class KeyValueSheet extends StatelessWidget {
  const KeyValueSheet({super.key, required this.title, required this.list, this.controller, this.onChanged, this.isApiValue = false, this.searchController, this.scrollController, this.controllerid});

  final String title;
  final List<KeyValue> list;
  final TextEditingController? controller;
  final TextEditingController? controllerid;
  final ScrollController? scrollController;
  final TextEditingController? searchController;
  final Function(String)? onChanged;
  final bool isApiValue;

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<MainController>().profile.value;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [AppText(title, size: 16, color: primaryClr, family: inter500), GestureDetector(onTap: () => Screen.closeDialog(result: false), child: const Icon(Icons.close))]),
      ),
      if (isApiValue)
        AppTextField(
          // onTap: () => Screen.open(const AllProductScreen(isSearch: true, isShowStocks: false)),
          hint: "Find a specific option..",
          suffixIcon: const Icon(CupertinoIcons.search, size: 20),
          controller: searchController,
          onChanged: onChanged,
        ),
      10.hBox,
      const Divider(color: inputBorderClr, height: 0),
      if (!isApiValue)
        list.isNotEmpty
            ? Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => ListTile(
                          title: AppText(list[index].name?.upperFirst, family: inter500),
                          onTap: () {
                            controller?.text = list[index].name ?? "";
                            controllerid?.text = list[index].id ?? "";
                            Screen.closeDialog(result: true);
                          },
                          contentPadding: const EdgeInsets.symmetric(vertical: 4),
                          visualDensity: const VisualDensity(horizontal: -4),
                        ),
                    separatorBuilder: (context, index) => const Divider(height: 0, color: inputBorderClr),
                    itemCount: list.length),
              )
            : AppErrorText(title: title),
      if (isApiValue)
        Obx(() {
          return list.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => ListTile(
                            title: Row(
                              children: [
                                AppText(list[index].name?.upperFirst, family: inter500),

                                //
                                const Spacer(),

                                list[index].id == profile?.id
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(color: primaryClr.withOpacity(0.6), borderRadius: BorderRadius.circular(8)),
                                        child: const AppText("Self Assign", family: inter500, size: 12, color: Colors.white))
                                    : 0.hBox
                              ],
                            ),
                            onTap: () {
                              controller?.text = list[index].name ?? "";
                              controllerid?.text = list[index].id ?? "";
                              Screen.closeDialog(result: true);
                            },
                            contentPadding: const EdgeInsets.symmetric(vertical: 4),
                            visualDensity: const VisualDensity(horizontal: -4),
                          ),
                      separatorBuilder: (context, index) => const Divider(height: 0, color: inputBorderClr),
                      itemCount: list.length),
                )
              : AppErrorText(title: title);
        }),
    ]);
  }
}
