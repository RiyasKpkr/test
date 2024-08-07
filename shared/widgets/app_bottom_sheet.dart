import 'package:cpsales/app/model/brand.dart';
import 'package:cpsales/app/model/key_value.dart';
import 'package:cpsales/app/widgets/key_value_sheet.dart';
import 'package:cpsales/core/extensions/context_ext.dart';
import 'package:cpsales/core/extensions/margin_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/model/prd_category.dart';
import '../../app/model/product.dart';

Future<T?> openAppBottomSheet<T>(Widget page,
        {bool isDismissible = true}) async =>
    await Get.bottomSheet(
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SafeArea(child: page),
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        isDismissible: isDismissible,
        isScrollControlled: true);

Future<dynamic> openKeyValueSheet(
    {String? title,
    required List<KeyValue> list,
    required TextEditingController controller,
    Function(String)? onChanged,
    bool isApiValue = false,
    TextEditingController? searchController,
    TextEditingController? controllerid}) async {
  return Get.bottomSheet(
    DraggableScrollableSheet(
      maxChildSize: .9,
      minChildSize: .6,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hBox,
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: context.deviceSize.height * .015,
                    horizontal: context.deviceSize.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              10.hBox,
              Expanded(
                child: KeyValueSheet(
                  title: title ?? "Select option",
                  list: list,
                  controller: controller,
                  controllerid: controllerid,
                  scrollController: scrollController,
                  onChanged: onChanged,
                  searchController: searchController,
                  isApiValue: isApiValue,
                ),
              )
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}
Future<dynamic> openBarndSheet(
    {String? title,
    required List<Brand> list,
    required TextEditingController controller,
    Function(String)? onChanged,
    bool isApiValue = false,
    TextEditingController? searchController,
    TextEditingController? controllerid}) async {
  return Get.bottomSheet(
    DraggableScrollableSheet(
      maxChildSize: .9,
      minChildSize: .6,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hBox,
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: context.deviceSize.height * .015,
                    horizontal: context.deviceSize.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              10.hBox,
              Expanded(
                child: BrandSheet(
                  title: title ?? "Select option",
                  list: list,
                  controller: controller,
                  controllerid: controllerid,
                  scrollController: scrollController,
                  onChanged: onChanged,
                  searchController: searchController,
                  isApiValue: isApiValue,
                ),
              )
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}

Future<PrdCategory> openProdcutCategorySheet({
  String? title,
  required List<PrdCategory> list,
  required TextEditingController controller,
  TextEditingController? controllerid,
  Function(String)? onChanged,
  bool isApiValue = false,
}) async {
  await Get.bottomSheet(
    DraggableScrollableSheet(
      maxChildSize: .9,
      minChildSize: .6,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hBox,
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: context.deviceSize.height * .015,
                    horizontal: context.deviceSize.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              10.hBox,
              Expanded(
                  child: ProductCategoryValueSheet(
                title: title ?? "Select option",
                list: list,
                controller: controller,
                controllerid: controllerid,
                scrollController: scrollController,
                onChanged: onChanged,
                isApiValue: isApiValue,
              ))
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );

  return PrdCategory(
    isSelected: false,
  );
}

Future<PrdCategory> openProdcutSheet({
  String? title,
  required List<Product> list,
  required TextEditingController controller,
  required TextEditingController selectProductId,
  required TextEditingController selectProductPrice,
  final List<Brand>? selectProductBrands,
  required TextEditingController selectProductTax,
  required TextEditingController selectProductQuantity,
  required TextEditingController selectProductImage,
  Function(String)? onChanged,
  bool isApiValue = false,
}) async {
  await Get.bottomSheet(
    DraggableScrollableSheet(
      maxChildSize: .9,
      minChildSize: .6,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hBox,
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: context.deviceSize.height * .015,
                    horizontal: context.deviceSize.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              10.hBox,
              Expanded(
                  child: ProductValueSheet(
                title: title ?? "Select option",
                list: list,
                selectProductPrice: selectProductPrice,
                selectProductId: selectProductId,
                controller: controller,
                selectProductQuantity: selectProductQuantity,
                selectProductTax: selectProductTax,
                selectProductBrands: selectProductBrands,
                scrollController: scrollController,
                isApiValue: isApiValue,
                onChanged: onChanged,
                selectProductImage: selectProductImage,
              ))
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
  return PrdCategory(
    isSelected: false,
  );
}


Future<Brand> openBrandSheet({
  String? title,
  required List<Brand> list,
  required TextEditingController controller,
  TextEditingController? controllerid,
  Function(String)? onChanged,
  bool isApiValue = false,
}) async {
  await Get.bottomSheet(
    DraggableScrollableSheet(
      maxChildSize: .9,
      minChildSize: .6,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hBox,
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: context.deviceSize.height * .015,
                    horizontal: context.deviceSize.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              10.hBox,
              Expanded(
                  child: BrandValueSheet(
                title: title ?? "Select option",
                list: list,
                controller: controller,
                controllerid: controllerid,
                scrollController: scrollController,
                onChanged: onChanged,
                isApiValue: isApiValue,
              ))
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );

  return Brand(
    isSelected: false,
  );
}
