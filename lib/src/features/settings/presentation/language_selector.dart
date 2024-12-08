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
  const LanguageSelector(
      {super.key, required this.uiModeController, required this.context});
  final UiModeController uiModeController;
  final BuildContext context;

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LanguageProvider>(widget.context, listen: false)
          .checkAndSetSystemLanguage(
              snackbarOnLanguageChanged: snackbarOnLanguageChanged);
    });

    snackbarOnLanguageChanged();
  }

  void snackbarOnLanguageChanged() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (widget.context.mounted) {
        if (!supportedLocale.contains(systemLang) &&
            Provider.of<LanguageProvider>(widget.context, listen: false)
                    .userSelectedLangFromPast ==
                null &&
            isStartedNew) {
          isStartedNew = false;
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Your language settings are not supported on our site. You are viewing the site in ",
                    ),
                    TextSpan(
                      text: "English",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ". All formatting settings of your language will be applied.",
                    ),
                  ],
                ),
              ),
              duration: const Duration(seconds: 4),
              backgroundColor: widget.uiModeController.darkModeSet
                  ? snackBarColorDark
                  : snackBarColorLight,
            ),
          );
        } else if (supportedLocale.contains(systemLang) && isStartedNew) {
          isStartedNew = false;
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(widget.context)!
                  .langCopiedFromSettingsMessage),
              duration: const Duration(seconds: 4),
              backgroundColor: widget.uiModeController.darkModeSet
                  ? snackBarColorDark
                  : snackBarColorLight,
            ),
          );
        } else if (Provider.of<LanguageProvider>(widget.context, listen: false)
                    .userSelectedLangFromPast !=
                null &&
            isStartedNew) {
          isStartedNew = false;
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(widget.context)!
                  .languageSettingsCopiedFromLastTimeMessage),
              duration: const Duration(seconds: 4),
              backgroundColor: widget.uiModeController.darkModeSet
                  ? snackBarColorDark
                  : snackBarColorLight,
            ),
          );
        }
      }
    });
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales != null && locales.isNotEmpty) {
      Provider.of<LanguageProvider>(widget.context, listen: false)
          .checkAndSetSystemLanguage(
              snackbarOnLanguageChanged: snackbarOnLanguageChanged);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TooltipAndSelectable(
          isTooltip: true,
          isSelectable: false,
          message: AppLocalizations.of(context)!.langSelectHover,
          child: DropdownButton<Locale>(
            isDense: true,
            menuWidth: 140,
            value: languageProvider.userSelectedLang,
            onChanged: (Locale? newValue) {
              if (newValue != null &&
                  newValue != languageProvider.userSelectedLang) {
                LanguageService().updateLanguage(newValue.languageCode);
                languageProvider.userSelectedLang = newValue;

                Future.delayed(const Duration(milliseconds: 1), () {
                  if (context.mounted) {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .switchLanguageMessage),
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
          message: AppLocalizations.of(context)!.onHoverSystemLang,
          child: Row(
            children: [
              Text(
                '${AppLocalizations.of(context)!.systemLang}: ${LanguageCodes.fromCode(systemLang.languageCode).nativeName}',
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
