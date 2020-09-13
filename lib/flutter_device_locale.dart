import 'dart:ui';

import 'src/platform.dart';

class DeviceLocale {
  static Future<Locale> getCurrentLocale() async {
    final deviceLocales = await getPreferredLocales();

    return deviceLocales.first;
  }

  static Future<List<Locale>> getPreferredLocales() async {
    final List<String> deviceLocales =
    await FlutterDeviceLocalePlatform.instance.deviceLocales();

    return deviceLocales.map((x) => _localeFromString(x)).toList();
  }

  static Locale _localeFromString(String code) {
    var separator = code.contains('_') ? r'_' : code.contains('-') ? r'-' : null;

    if (separator != null) {
      var parts = code.split(RegExp(separator));

      return parts.length >= 3 ? Locale.fromSubtags(
          languageCode: parts[0],
          scriptCode: parts[1],
          countryCode: parts[2])
          : Locale(parts[0], parts[1]);
    } else {
      return Locale(code);
    }
  }
}
