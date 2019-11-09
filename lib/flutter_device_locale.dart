import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class FlutterDeviceLocale
{
    static const MethodChannel _channel = const MethodChannel('flutter_device_locale');

    static Future<Locale> getCurrentLocale() async
    {
        final deviceLocales = await getPreferredLocales();

        return _localeFromString(deviceLocales.first);
    }

    static Future<List> getPreferredLocales() async
    {
      final List deviceLocales = await _channel.invokeMethod('deviceLocales');

      return deviceLocales;
    }

    static Locale _localeFromString(String code)
    {
        var separator = code.contains('_') ? '_' : code.contains('-') ? '-' : null;

        if (separator != null)
        {
            var parts = code.split(RegExp(separator));

            return Locale(parts[0], parts[1]);
        }
        else
        {
            return Locale(code);
        }
    }
}
