import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/application/scaffold_messenger_key.dart';
import 'package:arifayduran_dev/src/features/settings/application/services/language_service.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:language_code/language_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:dash_flags/dash_flags.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key, required this.uiModeController});
  final UiModeController uiModeController;

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector>
    with WidgetsBindingObserver {
  late final LanguageProvider languageProvider;
  late AppLocalizations _appLocalizationOfContext;

  @override
  void initState() {
    super.initState();

    languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      languageProvider.checkAndSetSystemLanguage();
      snackbarOnLanguageChanged();
    });
  }

  void snackbarOnLanguageChanged() {
    bool showLastRouteMessage =
        routeHistory!.isNotEmpty && activateLastRouteMessage;
    _appLocalizationOfContext = AppLocalizations.of(context)!;

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!supportedLocale.contains(systemLang) &&
          languageProvider.userSelectedLangFromPast == null &&
          activateSecondSnackBar) {
        activateSecondSnackBar = false;
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text:
                          "Your language settings are not supported on our site. You are viewing the site in ",
                      style: TextStyle(
                        color: widget.uiModeController.darkModeSet
                            ? snackBarTextColorDark
                            : snackBarTextColorLight,
                      )),
                  TextSpan(
                    text: "English",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.uiModeController.darkModeSet
                          ? snackBarTextColorDark
                          : snackBarTextColorLight,
                    ),
                  ),
                  TextSpan(
                      text:
                          ". All formatting settings of your language will be applied. ",
                      style: TextStyle(
                        color: widget.uiModeController.darkModeSet
                            ? snackBarTextColorDark
                            : snackBarTextColorLight,
                      )),
                  TextSpan(
                      text: showLastRouteMessage
                          ? _appLocalizationOfContext.lastRouteMessage
                          : "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.uiModeController.darkModeSet
                            ? snackBarTextColorDark
                            : snackBarTextColorLight,
                      )),
                ],
              ),
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: widget.uiModeController.darkModeSet
                ? snackBarColorDark
                : snackBarColorLight,
          ),
        );
      } else if (supportedLocale.contains(systemLang) &&
          activateSecondSnackBar) {
        activateSecondSnackBar = false;
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              "${_appLocalizationOfContext.langCopiedFromSettingsMessage} ${showLastRouteMessage ? _appLocalizationOfContext.lastRouteMessage : ""}",
              style: TextStyle(
                color: widget.uiModeController.darkModeSet
                    ? snackBarTextColorDark
                    : snackBarTextColorLight,
              ),
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: widget.uiModeController.darkModeSet
                ? snackBarColorDark
                : snackBarColorLight,
          ),
        );
      } else if (languageProvider.userSelectedLangFromPast != null &&
          activateSecondSnackBar) {
        activateSecondSnackBar = false;
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              "${_appLocalizationOfContext.languageSettingsCopiedFromLastTimeMessage} ${showLastRouteMessage ? _appLocalizationOfContext.lastRouteMessage : ""}",
              style: TextStyle(
                color: widget.uiModeController.darkModeSet
                    ? snackBarTextColorDark
                    : snackBarTextColorLight,
              ),
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: widget.uiModeController.darkModeSet
                ? snackBarColorDark
                : snackBarColorLight,
          ),
        );
      }
    });
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales != null && locales.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _appLocalizationOfContext = AppLocalizations.of(context)!;
        languageProvider.checkAndSetSystemLanguage(
            snackbarOnLanguageChanged: snackbarOnLanguageChanged);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizationOfContext = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TooltipAndSelectable(
          isTooltip: true,
          isSelectable: false,
          message: _appLocalizationOfContext.langSelectHover,
          child: DropdownButton<Locale>(
            isDense: true,
            menuWidth: 140,
            value: languageProvider.currentLocale,
            onChanged: (Locale? newValue) {
              if (newValue != null &&
                  newValue != languageProvider.currentLocale) {
                LanguageService().updateLanguage(newValue.languageCode);
                languageProvider.userSelectedLang = newValue;

                Future.delayed(const Duration(milliseconds: 1), () {
                  if (context.mounted) {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text(
                          _appLocalizationOfContext.switchLanguageMessage,
                          style: TextStyle(
                            color: widget.uiModeController.darkModeSet
                                ? snackBarTextColorDark
                                : snackBarTextColorLight,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: widget.uiModeController.darkModeSet
                            ? snackBarColorDark
                            : snackBarColorLight,
                      ),
                    );
                  }
                });
              }
            },
            items:
                supportedLocale.map<DropdownMenuItem<Locale>>((Locale value) {
              return DropdownMenuItem<Locale>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LanguageCodes.fromCode(value.languageCode).nativeName),
                    const SizedBox(
                      width: 11,
                    ),
                    LanguageFlag(
                      language: Language.fromCode(value.languageCode),
                      height: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        TooltipAndSelectable(
          isSelectable: false,
          isTooltip: true,
          message: _appLocalizationOfContext.onHoverSystemLang,
          child: Row(
            children: [
              Text(
                '${_appLocalizationOfContext.systemLang}: ${LanguageCodes.fromCode(systemLang.languageCode).nativeName}',
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(
                width: 5,
              ),
              LanguageFlag(
                language: Language.fromCode(systemLang.languageCode),
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
