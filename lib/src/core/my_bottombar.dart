// import 'package:arifayduran_dev/src/config/theme.dart';
// import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
// import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
// import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
// import 'package:arifayduran_dev/src/presentation/svg_color_mapper.dart';
// import 'package:arifayduran_dev/src/presentation/svg_shadow_painter_oval.dart';
// import 'package:arifayduran_dev/src/presentation/widgets/animated_text_widget.dart';
// import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_framework/responsive_framework.dart';

// class BottombarProvider extends ChangeNotifier {
//   late double providersMaxBottombarHeight; // didnt use for now
//   late double providersMinBottombarHeight; // didnt use for now
//   late double bottombarHeight;
//   Duration duration;
//   Color scrolledPlaceColor;

//   BottombarProvider({
//     this.duration = const Duration(milliseconds: toolbarAnimationDuration),
//     this.scrolledPlaceColor = effectColorDark,
//   }) {
//     providersMaxBottombarHeight = maxBarsHeight;
//     providersMinBottombarHeight = minBarsHeight;
//     bottombarHeight = providersMaxBottombarHeight;
//   }

//   void updateBottombar(Color color, double height, Duration newDuration) {
//     duration = newDuration;
//     scrolledPlaceColor = color;
//     bottombarHeight = height;

//     notifyListeners();
//   }
// }

// class MyBottombar extends StatefulWidget {
//   const MyBottombar({super.key, required this.uiModeController});

//   final UiModeController uiModeController;

//   @override
//   State<MyBottombar> createState() => _MyBottombarProvider();
// }

// class _MyBottombarProvider extends State<MyBottombar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _heightAnimation;
//   late double _currentHeight;

//   @override
//   void initState() {
//     super.initState();

//     widget.uiModeController.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//     final bottombarProvider =
//         Provider.of<BottombarProvider>(context, listen: false);
//     _currentHeight = bottombarProvider.bottombarHeight;

//     _controller = AnimationController(
//       vsync: this,
//       duration: bottombarProvider.duration,
//     );

//     _heightAnimation = Tween<double>(
//       begin: _currentHeight,
//       end: bottombarProvider.bottombarHeight,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     bottombarProvider.addListener(() {
//       _animateBottombarHeight(bottombarProvider.bottombarHeight);
//     });
//   }

//   void _animateBottombarHeight(double newHeight) {
//     if (!mounted) return;
//     setState(() {
//       _heightAnimation = Tween<double>(
//         begin: _currentHeight,
//         end: newHeight,
//       ).animate(CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ));

//       _currentHeight = newHeight;
//     });

//     _controller.reset();
//     _controller.forward();
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   super.didChangeDependencies();
//   //   setState(() {});
//   // }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     BottombarProvider bottombarProvider =
//         Provider.of<BottombarProvider>(context);
//     return AnimatedContainer(
//       duration: bottombarProvider.duration,
//       curve: Curves.easeInOut,
//       height: bottombarProvider.bottombarHeight,
//       color: bottombarProvider.scrolledPlaceColor,
//       child: AppBar(
//         backgroundColor: Colors.transparent,
//         toolbarHeight: _heightAnimation.value,
//         leadingWidth: bottombarProvider.bottombarHeight * 2,
//         leading: SizedBox(
//             height: bottombarProvider.bottombarHeight,
//             child: widget.uiModeController.darkModeSet
//                 ? CustomPaint(
//                     painter: SvgShadowPainterOval(
//                         shadowColor: touchColorDark, shouldReverse: true),
//                     child: SvgPicture(SvgAssetLoader(
//                         "assets/app_icons/logo_graphic_bottom_SVG.svg",
//                         colorMapper: SvgColorMapper(
//                             fromColor: const Color(0xFFD02A1E),
//                             toColor: touchColorDark,
//                             fromSecondColor: const Color(0xFFFFFFFF),
//                             toSecondColor: secondaryTouchColorDark))))
//                 : CustomPaint(
//                     painter: SvgShadowPainterOval(
//                         shadowColor: secondaryTouchColorLight,
//                         shouldReverse: true),
//                     child: SvgPicture(SvgAssetLoader(
//                         "assets/app_icons/logo_graphic_bottom_SVG.svg",
//                         colorMapper: SvgColorMapper(
//                             fromColor: const Color(0xFFD02A1E),
//                             toColor: touchColorLight,
//                             fromSecondColor: const Color(0xFFFFFFFF),
//                             toSecondColor: secondaryTouchColorLight))))),
//         automaticallyImplyLeading: false,
//         // title: Row(
//         //   children: [
//         //     Expanded(
//         //       child: !ResponsiveBreakpoints.of(context).smallerThan(MOBILE)
//         //           ? TooltipAndSelectable(
//         //               isTooltip: true,
//         //               isSelectable: false,
//         //               message:
//         //                   "${AppLocalizations.of(context)!.appTitle} - ${AppLocalizations.of(context)!.appDescription}",
//         //               child: AnimatedTextWidget(
//         //                 text:
//         //                     "ArifAyduran.dev", // AppLocalizations.of(context)!.appTitle,
//         //                 hoverColor: widget.uiModeController.darkModeSet
//         //                     ? secondaryTouchColorDark
//         //                     : secondaryTouchColorLight,
//         //                 initColor: widget.uiModeController.darkModeSet
//         //                     ? touchColorDark
//         //                     : touchColorLight,
//         //                 minSize: !ResponsiveBreakpoints.of(context)
//         //                         .smallerThan("Big")
//         //                     ? 45
//         //                     : 30,
//         //                 midSize: !ResponsiveBreakpoints.of(context)
//         //                         .smallerThan("Big")
//         //                     ? 55
//         //                     : 35,
//         //                 maxSize: !ResponsiveBreakpoints.of(context)
//         //                         .smallerThan("Big")
//         //                     ? 70
//         //                     : 40,
//         //                 fontWeight: FontWeight.w400,
//         //                 textStyle: GoogleFonts.beauRivage(letterSpacing: 2),
//         //                 enableFirstAnimation:
//         //                     isFirstLaunchAnimationsDone ? false : true,

//         //                 specialIndexes: [0, 4, 11, 12, 13, 14],
//         //                 elevatedIndexes: [11, 12, 13, 14],
//         //                 scaleFactors: {11: 0.5, 12: 0.5, 13: 0.5, 14: 0.5},
//         //               ),
//         //             )
//         //           : SizedBox(),
//         //     ),
//         //     if (!ResponsiveBreakpoints.of(context).smallerThan("Big"))
//         //       Row(
//         //         children: [
//         //           TooltipAndSelectable(
//         //             isTooltip: true,
//         //             isSelectable: false,
//         //             message: widget.uiModeController.darkModeSet
//         //                 ? AppLocalizations.of(context)!.toggleHoverToLight
//         //                 : AppLocalizations.of(context)!.toggleHoverToDark,
//         //             child: UiModeSwitch(
//         //               uiModeController: widget.uiModeController,
//         //             ),
//         //           ),
//         //           const SizedBox(
//         //             width: 20,
//         //           ),
//         //           LanguageSelector(
//         //             uiModeController: widget.uiModeController,
//         //           ),
//         //         ],
//         //       ),
//         //     if (ResponsiveBreakpoints.of(context).smallerThan("Big"))
//         //       Tooltip(
//         //         message: AppLocalizations.of(context)!.drawerOnHover,
//         //         child: PopupMenuButton<Widget>(
//         //           icon: const Icon(Icons.menu_rounded),
//         //           itemBuilder: (context) => <PopupMenuEntry<Widget>>[
//         //             PopupMenuItem(
//         //               enabled: false,
//         //               child: Center(
//         //                 child: LanguageSelector(
//         //                   uiModeController: widget.uiModeController,
//         //                 ),
//         //               ),
//         //             ),
//         //             PopupMenuDivider(),
//         //             PopupMenuItem<Widget>(
//         //               enabled: false,
//         //               child: Center(
//         //                 child: TooltipAndSelectable(
//         //                   isTooltip: true,
//         //                   isSelectable: false,
//         //                   message: widget.uiModeController.darkModeSet
//         //                       ? AppLocalizations.of(context)!.toggleHoverToLight
//         //                       : AppLocalizations.of(context)!.toggleHoverToDark,
//         //                   child: UiModeSwitch(
//         //                     uiModeController: widget.uiModeController,
//         //                   ),
//         //                 ),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       )
//         //   ],
//         // ),
//       ),
//     );
//   }
// }
