// import 'package:core_ui/core_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';


// class AppHeader extends StatelessWidget {
//   const AppHeader(
//       {Key? key,
//       this.title,
//       this.subtitle,
//       this.showBackBtn = true,
//       this.isTransparent = false,
//       this.onBack,
//       this.trailing,
//       this.backIcon,
//       this.backBtnSemantics})
//       : super(key: key);
//   final String? title;
//   final String? subtitle;
//   final bool showBackBtn;
//   final Widget? backIcon;
//   final String? backBtnSemantics;
//   final bool isTransparent;
//   final VoidCallback? onBack;
//   final Widget Function(BuildContext context)? trailing;

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: isTransparent ? Colors.transparent : AppColors.vWhite,
//       child: SafeArea(
//         bottom: false,
//         child: SizedBox(
//           height: 64 * 1.25,
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: Center(
//                   child: Row(children: [
//                     const Gap(16),
//                     if (showBackBtn)
//                       // BackBtn(
//                       //   onPressed: onBack,
//                       //   icon: backIcon,
//                       //   semanticLabel: backBtnSemantics,
//                       // ),
//                       GestureDetector(
//                         onTap: () => onBack,
//                         child: backIcon ?? MyAssets.icons.iconArrowLeft.image(),
//                       )
//                      Spacer(),
//                     if (trailing != null) trailing!.call(context),
//                     const Gap(16),
//                     //if (showBackBtn) Container(width: $styles.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
//                   ]),
//                 ),
//               ),
//               MergeSemantics(
//                 child: Semantics(
//                   header: true,
//                   child: Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (title != null)
//                           Text(
//                             title!.toUpperCase(),
//                             textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
//                             style:
//                                 $styles.text.h4.copyWith(color: $styles.colors.offWhite, fontWeight: FontWeight.w500),
//                           ),
//                         if (subtitle != null)
//                           Text(
//                             subtitle!.toUpperCase(),
//                             textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
//                             style: $styles.text.title1.copyWith(color: $styles.colors.accent1),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
