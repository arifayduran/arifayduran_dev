import 'dart:ui';

import 'package:arifayduran_dev/src/config/route_links.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double offset = 0;
  int lastUpdateTime = 0;
  double blurring = 0;
  final ScrollController _scrollController = ScrollController();

  late Color scrolledPlaceColor;
  final Color _effectColorLight = effectColorLight;
  final Color _effectColorDark = effectColorDark;
  final Color _destinationColorDark = destinationColorDark;
  final Color _destinationColorLight = destinationColorLight;

  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        _transformationController.value = _animation!.value;
      });

    scrolledPlaceColor = widget.uiModeController.darkModeSet
        ? _effectColorDark
        : _effectColorLight;

    widget.uiModeController.addListener(() {
      setState(() {
        scrolledPlaceColor =
            _getScrolledPlaceColor(_scrollController.position.pixels);
      });
    });

    _scrollController.addListener(() {
      setState(() {
        scrolledPlaceColor =
            _getScrolledPlaceColor(_scrollController.position.pixels);
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _routeIfLastVisitedRouteFromPastTemp();
    // }); // not using since observer
  }

  // void _routeIfLastVisitedRouteFromPastTemp() async {
  //   notNavigatedFromRefresh = true;
  //   await RouteService().getLastVisitedRoute();
  //   if (lastVisitedRouteFromPastTemp != null &&
  //       lastVisitedRouteFromPastTemp != "/" &&
  //       currentRoute != lastVisitedRouteFromPastTemp) {
  //     if (mounted) {
  //       Navigator.restorablePushNamed(context, lastVisitedRouteFromPastTemp!);
  //     }
  //   }
  // } // not using since observer

  Color _getScrolledPlaceColor(double pixels) {
    double opacity = pixels / (MediaQuery.of(context).size.height - 50 - 200);
    opacity = opacity.clamp(0.0, 1.0);
    return Color.lerp(
        widget.uiModeController.darkModeSet
            ? _effectColorDark
            : _effectColorLight,
        widget.uiModeController.darkModeSet
            ? _destinationColorDark
            : _destinationColorLight,
        opacity)!;
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
    );
  }

  bool _updateScrolling(ScrollNotification scrollNotification) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        offset = scrollNotification.metrics.pixels;
      });
    });
    return true;
  }

  void _handleDoubleTap() {
    Matrix4 endMatrix;
    Offset position = _doubleTapDetails!.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      endMatrix = Matrix4.identity();
    } else {
      endMatrix = Matrix4.identity()
        ..translate(-position.dx * 1, -position.dy * 1)
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _transformationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    double maxToolbarHeight = 70.0;
    double minToolbarHeight = 50.0;

    double relationFromOffset =
        (1.0 - (offset / (height - minToolbarHeight - 200))).clamp(0.0, 1.0);
    double toolbarHeight = double.parse((maxToolbarHeight -
            (maxToolbarHeight - minToolbarHeight) * (1 - relationFromOffset))
        .toStringAsFixed(0));

    double blurValue = offset > 0 ? 0.01 * offset : 0.0;
    blurValue = blurValue.clamp(0.0, 8.0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (willPop, result) {
        if (_scrollController.offset > 0) {
          _scrollToTop();
        }
      },
      child: Scaffold(
        backgroundColor: scrolledPlaceColor,
        appBar: AppBar(
          backgroundColor: scrolledPlaceColor,
          toolbarHeight: toolbarHeight,
          leadingWidth: toolbarHeight,
          leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: widget.uiModeController.darkModeSet
                  ? Image.asset("assets/app_icons/light_transparent.png")
                  : Image.asset("assets/app_icons/dark_transparent.png")),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: TooltipAndSelectable(
                  isTooltip: true,
                  isSelectable: false,
                  message: AppLocalizations.of(context)!.appDescription,
                  child: Text(
                    AppLocalizations.of(context)!.appTitle,
                  ),
                )),
                Flexible(
                    child: TooltipAndSelectable(
                  isTooltip: true,
                  isSelectable: false,
                  message: widget.uiModeController.darkModeSet
                      ? AppLocalizations.of(context)!.toggleHoverToLight
                      : AppLocalizations.of(context)!.toggleHoverToDark,
                  child: UiModeSwitch(
                    uiModeController: widget.uiModeController,
                  ),
                )),
                Flexible(
                  child: LanguageSelector(
                    uiModeController: widget.uiModeController,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onDoubleTapDown: (d) => _doubleTapDetails = d,
          onDoubleTap: _handleDoubleTap,
          child: InteractiveViewer(
            transformationController: _transformationController,
            scaleEnabled: false,
            minScale: 1,
            maxScale: 2,
            child: Material(
              child: NotificationListener<ScrollNotification>(
                onNotification: _updateScrolling,
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0, -.25 * offset),
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: const AssetImage(
                              "assets/images/business_smile_retuschiert_farbenangepasst_low_jpeg_50q_pixel40.jpg"),
                          // height: height < width
                          //     ? width / imageScale
                          //     : width / imageScale,
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                      SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: blurValue,
                                  sigmaY: blurValue,
                                ),
                                child: Container(
                                  width: width,
                                  height: height - maxToolbarHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          scrolledPlaceColor
                                          // .withOpacity(0.0)
                                          ,
                                          Colors.transparent
                                        ],
                                        stops: const [
                                          0,
                                          1
                                        ]),
                                  ),
                                  child: Center(
                                    child:
                                        // Selection?
                                        Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .greeting,
                                          style: nameStyle?.copyWith(),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .fullGreeting,
                                          style: descriptionStyle?.copyWith(),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .specialization,
                                          style: descriptionStyle?.copyWith(),
                                        ),
                                        Text(DateFormat.yMMMMEEEEd(
                                                systemLang.toString())
                                            // .add_jms()
                                            .format(DateTime.now())),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    bottom:
                                        -190, //   bottom: -height - height + 150 + maxToolbarHeight,
                                    child: Container(
                                      height: 200, //     height: height * 0.3,
                                      width: width,
                                      color: scrolledPlaceColor,
                                    )),
                                Container(
                                  height: height - 150 - minToolbarHeight,
                                  width: width,
                                  color: scrolledPlaceColor,
                                  child: Column(
                                    children: [
                                      TooltipAndSelectable(
                                        isTooltip: true,
                                        isSelectable: false,
                                        message: "Link to $wetterAppUrl",
                                        child: TextButton(
                                          onPressed: () {
                                            notNavigatedFromRefresh = true;
                                            Navigator.restorablePushNamed(
                                                context, '/projects');
                                          },
                                          child: Text(
                                            "Projects",
                                            style: descriptionStyle?.copyWith(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: -5,
                                    child: Container(
                                      height: 6,
                                      width: width,
                                      color: scrolledPlaceColor,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: width * 0.08,
                        bottom:
                            (height + maxToolbarHeight) * 0.08 - .25 * offset,
                        child: TooltipAndSelectable(
                          isTooltip: true,
                          isSelectable: false,
                          message: AppLocalizations.of(context)!.scrolldownText,
                          child: GestureDetector(
                            onTap: () {
                              _scrollToBottom();
                            },
                            child: Lottie.asset(widget
                                    .uiModeController.darkModeSet
                                ? "assets/animations/scroll_down_white.json"
                                : "assets/animations/scroll_down_black.json"),
                          ),
                        ),
                      ),
                      Positioned(
                        right: width * 0.08,
                        top: -(height + 200 - minToolbarHeight) * 0.08 +
                            .25 * offset,
                        child: TooltipAndSelectable(
                          isSelectable: false,
                          isTooltip: true,
                          message: AppLocalizations.of(context)!.scrollupText,
                          child: GestureDetector(
                            onTap: () {
                              _scrollToTop();
                            },
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: Lottie.asset(widget
                                      .uiModeController.darkModeSet
                                  ? "assets/animations/scroll_down_white.json"
                                  : "assets/animations/scroll_down_black.json"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
