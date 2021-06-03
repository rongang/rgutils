
import 'dart:async';

import 'package:flutter/services.dart';
export './widget_utils/slider_button.dart' show SliderButton;

class RgUtils {
  static const MethodChannel _channel =
      const MethodChannel('rgutils');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
