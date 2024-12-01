import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/src/config/my_custom_scroll_behavior.dart';
import 'package:portfolio/src/config/theme.dart';
import 'package:portfolio/src/features/settings/application/settings_controller.dart';
import 'package:portfolio/src/features/settings/presentation/dark_mode_switch.dart';
import 'package:transparent_image/transparent_image.dart';

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

    _scrollController.addListener(() {
      setState(() {
        scrolledPlaceColor =
            _getScrolledPlace(_scrollController.position.pixels);
      });
    });
  }

  Color _getScrolledPlace(double pixels) {
    double opacity = pixels / (MediaQuery.of(context).size.height - 52.03);
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
    double toolbarHeight = 70 - (offset * 0.015);

    // debugPrint(toolbarHeight.toString());

    return Scaffold(
      appBar: AppBar(
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
              Text("ARIF AYDURAN"),
              Flexible(
                  child: DarkModeSwitch(
                      settingsController: widget.settingsController))
            ],
          ),
        ),
      ),
      body: Material(
        child: NotificationListener<ScrollNotification>(
          onNotification: _updateScrolling,
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -.25 * offset,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          "assets/images/business_smile_retuschiert_farbenangepasst.jpg",
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
                      height: height - toolbarHeight,
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
                          )),
                    ),
                  ),
                  Positioned(
                    bottom: -195 + (.25 * offset),
                    child: Container(
                      width: width,
                      height: 200,
                      color: black,
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
                            child: SizedBox(
                              // height: width / imageScale,
                              height: height - toolbarHeight,
                              width: width,
                              child: Container(
                                width: width,
                                height: height - toolbarHeight,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        widget.settingsController.darkModeSet
                                            ? offset > height / 2
                                                ? effectColorDark
                                                    .withOpacity(0.1)
                                                : effectColorDark
                                            : effectColorLight,
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
                        ),
                        Container(
                          height: 100,
                          width: width,
                          color: widget.settingsController.darkModeSet
                              ? effectColorDark
                              : effectColorLight,
                          child: Text("data"),
                        ),
                        Container(
                          height: height - 100 - toolbarHeight,
                          width: width,
                          color: scrolledPlaceColor,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: width * 0.08,
                    bottom: height * 0.08 - .25 * offset,
                    child: ElevatedButton(
                        onPressed: () {
                          _scrollToBottom();
                        },
                        child: const Text("Scroll down")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
