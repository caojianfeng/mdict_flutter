import 'dart:async';

import 'package:flutter/services.dart';

class MdictFlutter {
  static const MethodChannel _channel = const MethodChannel('mdict_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static query(String source, String word, bool substyle, String passcode) {}
}
