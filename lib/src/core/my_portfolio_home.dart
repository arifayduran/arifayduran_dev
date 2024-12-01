import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/src/config/theme.dart';
import 'package:portfolio/src/features/settings/application/settings_controller.dart';
import 'package:portfolio/src/features/settings/presentation/dark_mode_switch.dart';
import 'package:transparent_image/transparent_image.dart';


// Bei desktop Version soll zoombar sein
// Bei desktop Version soll scrollbar sein und Pixel sollen mehr sein, also mehr im Bildschirm passen
// Du weisst doch dass wenn man über handy browser reingeht mobile seite (m.blabla) kommt, und man kann dann desktop seite anfordern, wie geht das in flutter?
// resp web https://www.youtube.com/watch?v=dAdNiSOmHzU

// Asagi scoll yaparken üsste blur olsun
// appbar kirmizi renk alsin??? +++ arka plan degismiyor???

class MyPortfolioHome extends StatefulWidget {
  const MyPortfolioHome({super.key, required this.settingsController});

  final SettingsController settingsController;
  static const routeName = '/';

  @override
  State<MyPortfolioHome> createState() => _MyPortfolioHomeState();
}

class _MyPortfolioHomeState extends State<MyPortfolioHome> {
  double offset = 0;
  double blurring = 0;
  final ScrollController _scrollController = ScrollController();

  late Color scrolledPlaceColor;
  Color effectColorLight = mainBlue;
  Color effectColorDark = mainRed;

  @override
  void initState() {
    super.initState();

    scrolledPlaceColor = widget.settingsController.darkModeSet
        ? effectColorDark
        : effectColorLight;

    widget.settingsController.addListener(() {
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
  }

  Color _getScrolledPlaceColor(double pixels) {
    double opacity = pixels / (MediaQuery.of(context).size.height - 50 - 200);
    opacity = opacity.clamp(0.0, 1.0);
    return Color.lerp(
        widget.settingsController.darkModeSet
            ? effectColorDark
            : effectColorLight,
        widget.settingsController.darkModeSet ? mainGrey : white,
        opacity)!;
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;
    // double imageScale = 1.4;

    double maxToolbarHeight = 70.0;
    double minToolbarHeight = 50.0;

    double relationFromOffset =
        (1.0 - (offset / (height - minToolbarHeight - 200))).clamp(0.0, 1.0);
    double toolbarHeight = double.parse((maxToolbarHeight -
            (maxToolbarHeight - minToolbarHeight) * (1 - relationFromOffset))
        .toStringAsFixed(0));

    // debugPrint(toolbarHeight.toString());

    // double scrollTurningPoint = height - minToolbarHeight - 250;
    double maxScroll = height - minToolbarHeight - 200;
    double relation = 1.0 - (offset / maxScroll);
    relation = relation.clamp(0.5, 1.0);

    // if (offset > scrollTurningPoint) {
    //   // debugPrint("offset inspect");

    //   opacity = 1.0 -
    //       ((offset - scrollTurningPoint) / (maxScroll - scrollTurningPoint));
    //   opacity = opacity.clamp(0.8, 0.9);
    // }

    // debugPrint(opacity.toString());

    return Scaffold(
      backgroundColor: scrolledPlaceColor,
      appBar: AppBar(
        backgroundColor: scrolledPlaceColor,
        toolbarHeight: toolbarHeight,
        leadingWidth: toolbarHeight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: widget.settingsController.darkModeSet
              // Image.asset(widget.settingsController.darkModeSet
              // ? Assets.logoBright
              // : Assets.logoDark),
              ? Container(
                  color: Colors.grey,
                )
              : Container(
                  color: Colors.blue,
                ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(child: Text("ARIF AYDURAN")),
              Flexible(
                child: DarkModeSwitch(
                  settingsController: widget.settingsController,
                ),
              )
            ],
          ),
        ),
      ),
      body: Material(
        child: NotificationListener<ScrollNotification>(
          onNotification: _updateScrolling,
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -.25 * offset,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage(
                        "assets/images/business_smile_retuschiert_farbenangepasst.jpg"),
                    // height: height < width
                    //     ? width / imageScale
                    //     : width / imageScale,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  top: -.25 * offset,
                  child: SizedBox(
                    // height: width / imageScale,
                    height: height - maxToolbarHeight,
                    width: width,
                    child: Align(
                      alignment: const Alignment(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Arif Ayduran",
                            style: nameStyle?.copyWith(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Proving learning coding, is easy',
                            style: descriptionStyle?.copyWith(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            sigmaX: offset > 0 ? 0.005 * offset : 0.0,
                            sigmaY: offset > 0 ? 0.005 * offset : 0.0,
                          ),
                          child: Container(
                            width: width,
                            height: height - maxToolbarHeight,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    scrolledPlaceColor,
                                    // widget.settingsController.darkModeSet
                                    //     ? scrolledPlaceColor
                                    //     : effectColorLight,
                                    Colors.transparent
                                  ],
                                  stops: const [
                                    0,
                                    1
                                  ]),
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
                  bottom: height * 0.08 - .25 * offset,
                  child: GestureDetector(
                    onTap: () {
                      _scrollToBottom();
                    },
                    child: Lottie.asset(widget.settingsController.darkModeSet
                        ? "assets/animations/scroll_down_black.json"
                        : "assets/animations/scroll_down_white.json"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
