import 'dart:ui';

import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/features/settings/data/language_settings.dart';
import 'package:arifayduran_dev/src/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// google einspruch

// TooltipAndSelectable teelfonda iyi secimiyor ya....... cift seciyor + hespini birden secsin?

// panEnabled test et!!!
// COK MB YIYOR???

// FOTOS & LOGO VR DHAA:: LOGO BASITLESTIR ISIM SADECE???/STERNE??? ISMI platFORMA AYNEN YÖYLE YAZARSIN YA?
// THEMES BITIR UND TEXTTHEMES
// Theme isleri ve 2 snacbar renk olayi ve animasyon renkleri2 ---- yazi renkleri siyah beyaz ters! -- snackbar neden bulanik -- // FARBPALETTE KOY!
// +++ tüm textleri bearb:::: theme ve renk olarak + tooltip&seolectable
// mesela auswählen yapinca saglam renk geliyor gri
// gradient sil ya??? / opacity fln?
// renk karar veriop logo yap

// Localizations state??? +++ dropdown +++ test et her türlüsünü & init ne olacak & bazi seyler degisecek mi? +++ vorschlagen yapsin + bevorzugte sprachen alsin browserdan yoksa eng, spanisch ise mesela spanisch yapsin ama englischden alsin önemli seyleri
// Selection ayarla kopy fln +++ renk
// SelectionArea düsün oluyor mu? Her yerde? Sadece web? +++ Tooltip übrall
// Fotos auch seletable machenß

// logo basinca logo acilsin yada startseite -- logo büyüsün
// APP BAR ÜSÜNE GELINCE BÜYÜSÜN?
// OFSET 0.25 rechnung düsür round fln yapsin

// WETTER APP TAM YAP BITIR YA???

// TEst schatten

// sag tik linke
// appname arifayduran.dev überall und localizations

// - [ ] İlk mavi renk geliyor?
// github yavas mi doluyor riske etme firebase daha iyi
// google seite einrichten! & icon falan gelecek mi? & beschreibung? baska daten? -- en basta gelsin & reklam ver -- https://support.google.com/webmasters/answer/7474347?hl=de#:~:text=Es%20kann%20einige%20Zeit%20dauern,Sie%20von%20einem%20Problem%20ausgehen.
// bewebbb icin inbearb yap
// webseite links überall: github fln + github readme yapip oraya da koy!
// lebenslauf koy !!!
// ksuite & email + weiterleitungen(sinirli mi?) + google cloud fln?
// Domain isleri bitir düsün + infomaaniak alle services bak
// Logo hintergr + logo degisirse infoman da degilsit + yazi + logologo ekle bosluk + komprime et? + dev sil ---- farbennnnn genel & themes kontrol ----- splash
// SAFARI tem
// Photoshio isleri + foto bearb!
// Appname überall arifayduran.dev yap???

// FFRAME UND PERFORMANCE CHECKKKKK GERCEK TELEFONDSA ::: FIREBASE KÖTÜ MESELA? DÜSÜR??? / GITHUB GEC YINE???(NE FARK EDECEK, dene bakalim) -- build html dene bir de???
// Bei desktop Version soll scrollbar sein und Pixel sollen mehr sein, also mehr im Bildschirm passen
// Du weisst doch dass wenn man über handy browser reingeht mobile seite (m.blabla) kommt, und man kann dann desktop seite anfordern, wie geht das in flutter?
// resp web https://www.youtube.com/watch?v=dAdNiSOmHzU

// Themes gözden gecir

// bewerbung yolla bitmeden*
// rive scroll animation bul
// safari all
// github jqueri olayi https://stackoverflow.com/questions/59653455/smooth-scrolling-doesnt-work-on-github-page
// appbar kirmizi renk alsin??? +++ arka plan degismiyor???

class MyPortfolioHome extends StatefulWidget {
  const MyPortfolioHome({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/';

  @override
  State<MyPortfolioHome> createState() => _MyPortfolioHomeState();
}

class _MyPortfolioHomeState extends State<MyPortfolioHome>
    with SingleTickerProviderStateMixin {
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
  }

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

  // bool _updateScrolling(ScrollNotification scrollNotification) {
  //   final int now = DateTime.now().millisecondsSinceEpoch;
  //   final int frameDuration = (1000 / 120).round();

  //   if (now - lastUpdateTime >= frameDuration) {
  //     lastUpdateTime = now;

  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       setState(() {
  //         offset = scrollNotification.metrics.pixels;
  //       });
  //     });
  //   }

  //   return true;
  // }

  // double lastOffset = 0.0;

  // bool _updateScrolling(ScrollNotification scrollNotification) {
  //   double newOffset = scrollNotification.metrics.pixels;

  //   if ((newOffset - lastOffset).abs() > 10) {
  //     lastOffset = newOffset;

  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       setState(() {
  //         offset = newOffset;
  //         scrolledPlaceColor =
  //             _getScrolledPlaceColor(_scrollController.position.pixels);
  //       });
  //     });
  //   }

  //   return true;
  // }

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

    double blurValue = offset > 0 ? 0.01 * offset : 0.0;
    blurValue = blurValue.clamp(0.0, 8.0);

    // debugPrint(toolbarHeight.toString());
    // debugPrint(offset.toString());

    // double maxScroll = height - minToolbarHeight - 200;
    // double relation = 1.0 - (offset / maxScroll);
    // relation = relation.clamp(0.5, 1.0);

    // double scrollTurningPoint = height - minToolbarHeight - 250;
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
                  context: context,
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
          panEnabled: true,
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
                                  child: TooltipAndSelectable(
                                    child: Column(
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
                                //   child: TooltipAndSelectable(
                                //     isTooltip: false,
                                //     child: Text(
                                //       AppLocalizations.of(context)!.specialization,
                                //       style: descriptionStyle?.copyWith(),
                                //     ),
                                //   ),
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
                      bottom: (height + maxToolbarHeight) * 0.08 - .25 * offset,
                      child: TooltipAndSelectable(
                        isTooltip: true,
                        message: AppLocalizations.of(context)!.scrolldownText,
                        isSelectable: false,
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
                      right: width * 0.08,
                      top: -(height + 200 - minToolbarHeight) * 0.08 +
                          .25 * offset,
                      child: TooltipAndSelectable(
                        isTooltip: true,
                        message: AppLocalizations.of(context)!.scrollupText,
                        isSelectable: false,
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
