import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class Translate {
  final Locale locale;
  static const LocalizationsDelegate<Translate> delegate = AppLocaleDelegate();
  late Map<String, String> _localizedStrings;

  Translate(this.locale);

  static Translate of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate)!;
  }

  Future<bool> load() async {
    final jsonMap = await UtilAsset.loadJson(
      "assets/locale/${locale.languageCode}.json",
    );

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String? key) {
    return _localizedStrings[key] ?? key ?? '';
  }
}

class AppLocaleDelegate extends LocalizationsDelegate<Translate> {
  const AppLocaleDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLanguage.supportLanguage.contains(locale);
  }

  @override
  Future<Translate> load(Locale locale) async {
    Translate localizations = Translate(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocaleDelegate old) => false;
}
