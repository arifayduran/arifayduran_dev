import 'dart:math';
import 'dart:ui';

import 'dart:ui_web' as ui_web;
import 'package:universal_html/html.dart';

import 'package:arifayduran_dev/src/config/route_links.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/projects/presentation/projects_screen.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/presentation/widgets/my_custom_button.dart';
import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/';

  static double lastToolbarHeightBeforePush = maxToolbarHeight;
  static Color lastToolbarScrolledPlaceColorDark = effectColorDark;
  static Color lastToolbarScrolledPlaceColorLight = effectColorLight;

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
      if (mounted) {
        setState(() {
          scrolledPlaceColor =
              _getScrolledPlaceColor(_scrollController.position.pixels);
          _updateToolBar(scrolledPlaceColor, _getToolbarSize(), 0);
        });
      }
    });

    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          scrolledPlaceColor =
              _getScrolledPlaceColor(_scrollController.position.pixels);
          _updateToolBar(scrolledPlaceColor, _getToolbarSize(), 0);
        });
      }
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

  double _getToolbarSize() {
    double relationFromOffset = (1.0 -
            (offset /
                (MediaQuery.of(context).size.height - minToolbarHeight - 200)))
        .clamp(0.0, 1.0);
    return double.parse((maxToolbarHeight -
            (maxToolbarHeight - minToolbarHeight) * (1 - relationFromOffset))
        .toStringAsFixed(0));
  }

  void _updateToolBar(Color color, double height, int ms) {
    Provider.of<ToolbarProvider>(context, listen: false)
        .updateToolBar(color, height, Duration(milliseconds: ms));
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

  void _onRoute() {
    HomeScreen.lastToolbarHeightBeforePush = _getToolbarSize();
    double opacity = (_scrollController.position.pixels /
            (MediaQuery.of(context).size.height - 50 - 200))
        .clamp(0.0, 1.0);

    HomeScreen.lastToolbarScrolledPlaceColorDark =
        Color.lerp(_effectColorDark, _destinationColorDark, opacity)!;
    HomeScreen.lastToolbarScrolledPlaceColorLight =
        Color.lerp(_effectColorLight, _destinationColorDark, opacity)!;
  }

  @override
  bool get wantKeepAlive => true;

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

    ui_web.platformViewRegistry.registerViewFactory(
      'canva-embed',
      (int viewId) {
        final iframe = IFrameElement()
          ..src =
              'https://www.canva.com/design/DAGTpv3gQGs/arcIIPMac_ejOlJ-WRHDfA/view?embed'
          ..style.border = 'none'
          ..style.position = 'absolute'
          ..style.width = '100%'
          ..style.height = '100%';
        return iframe;
      },
    );

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    double maxToolbarHeight = 70.0;
    double minToolbarHeight = 50.0;

    double blurValue = offset > 0 ? 0.01 * offset : 0.0;
    blurValue = blurValue.clamp(0.0, 8.0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (willPop, result) {
        if (_scrollController.offset > 0) {
          _scrollToTop();
        }
      },
      child: GestureDetector(
        onDoubleTapDown: (d) => _doubleTapDetails = d,
        onDoubleTap: _handleDoubleTap,
        child: InteractiveViewer(
          transformationController: _transformationController,
          scaleEnabled: false, // issues
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
                                        // .withValues(alpha:0.0)
                                        ,
                                        Colors.transparent
                                      ],
                                      stops: const [
                                        0,
                                        1
                                      ]),
                                ),
                                child: Align(
                                  alignment: const Alignment(-0.2, 0.4),
                                  child:
                                      // Selection?
                                      Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)!.greeting,
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
                                      -390, //   bottom: -height - height + 150 + maxToolbarHeight,
                                  child: Container(
                                    height: 400, //     height: height * 0.3,
                                    width: width,
                                    color: scrolledPlaceColor,
                                  )),
                              Container(
                                height: height - 150 - minToolbarHeight,
                                width: width,
                                color: scrolledPlaceColor,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: MyCustomButton(
                                      //       text: "csdcscsadvsdvsdvsdv",
                                      //       onPressed: () {}),
                                      // ),
                                      TooltipAndSelectable(
                                        isTooltip: true,
                                        isSelectable: false,
                                        message: "Link to $wetterAppUrl",
                                        child: TextButton(
                                          onPressed: () {
                                            notNavigatedFromRefresh = true;

                                            _onRoute();
                                            _updateToolBar(
                                                widget.uiModeController
                                                        .darkModeSet
                                                    ? ProjectsScreen
                                                        .lastToolbarScrolledPlaceColorDark
                                                    : ProjectsScreen
                                                        .lastToolbarScrolledPlaceColorLight,
                                                ProjectsScreen
                                                    .lastToolbarHeightBeforePush,
                                                1000);
                                            Navigator.pushNamed(
                                                context, '/projects');
                                          },
                                          child: Text(
                                            "Hier zu meinen Projekten",
                                            style: descriptionStyle?.copyWith(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text("Lebenslauf:"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: width * 0.8,
                                        height: height * 0.7,
                                        child: const HtmlElementView(
                                            viewType: 'canva-embed'),
                                      ),
                                    ],
                                  ),
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
                      right: width * 0.1,
                      bottom: height * 0.1 - .25 * offset,
                      child: TooltipAndSelectable(
                        isTooltip: true,
                        isSelectable: false,
                        message: AppLocalizations.of(context)!.scrolldownText,
                        child: GestureDetector(
                          onTap: () {
                            _scrollToBottom();
                          },
                          child: Lottie.asset(
                              widget.uiModeController.darkModeSet
                                  ? "assets/animations/scroll_down_white.json"
                                  : "assets/animations/scroll_down_black.json"),
                        ),
                      ),
                    ),
                    Positioned(
                      right: width * 0.1,
                      top: (height * 0.1 + .25 * offset) -
                          ((-150 - 20 - height) * -.25) +
                          minToolbarHeight,
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
    );
  }
}
