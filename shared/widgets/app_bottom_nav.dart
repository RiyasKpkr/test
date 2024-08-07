// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../core/constants.dart';
// import '../../core/extensions/string_ext.dart';
// import '../../main_controller.dart';
// import '../utils/colors.dart';
// import 'app_svg.dart';

// class AppBottomNav extends StatelessWidget {
//   const AppBottomNav(
//       {super.key, required this.currentIndex, required this.onTap});

//   static const menus = ['home', 'leads', 'quote', 'products'];
//   static const menus2 = ['home', 'leads', 'products'];

//   final int currentIndex;
//   final void Function(int index) onTap;

//   @override
//   Widget build(BuildContext context) {
//     final profile = Get.find<MainController>().profile.value;
//     return BottomNavigationBar(
//       selectedFontSize: 12,
//       onTap: (index) => onTap(index),
//       currentIndex: currentIndex,
//       items: profile?.role == "CRE"
//           ? menus2
//               .map(
//                 (menu) => BottomNavigationBarItem(
//                   icon: Padding(
//                     padding: const EdgeInsets.only(bottom: 3),
//                     child: BnvIcon(
//                         iconName: "${menu}_bnv", color: bnvUnselectedClr),
//                   ),
//                   activeIcon: Padding(
//                     padding: const EdgeInsets.only(bottom: 3),
//                     child: BnvIcon(
//                         iconName: "${menu}_bnv_fill", color: bnvSelectedClr),
//                   ),
//                   label: menu.upperFirst,
//                 ),
//               )
//               .toList()
//           : menus
//               .map(
//                 (menu) => BottomNavigationBarItem(
//                   icon: Padding(
//                     padding: const EdgeInsets.only(bottom: 3),
//                     child: BnvIcon(
//                         iconName: "${menu}_bnv", color: bnvUnselectedClr),
//                   ),
//                   activeIcon: Padding(
//                     padding: const EdgeInsets.only(bottom: 3),
//                     child: BnvIcon(
//                         iconName: "${menu}_bnv_fill", color: bnvSelectedClr),
//                   ),
//                   label: menu.upperFirst,
//                 ),
//               )
//               .toList(),
//       showUnselectedLabels: true,
//       backgroundColor: Colors.white,
//       type: BottomNavigationBarType.fixed,
//       selectedLabelStyle: const TextStyle(
//           color: bnvSelectedClr, fontSize: 12, fontFamily: inter500),
//       unselectedLabelStyle: const TextStyle(
//           color: bnvUnselectedClr, fontSize: 12, fontFamily: inter500),
//       fixedColor: bnvSelectedClr,
//       landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
//     );
//   }
// }

// class BnvIcon extends StatelessWidget {
//   const BnvIcon({
//     super.key,
//     required this.iconName,
//     required this.color,
//   });

//   final String iconName;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: AppSvg(assetName: iconName, color: color),
//     );
//   }
// }
