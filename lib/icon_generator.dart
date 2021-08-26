import 'dart:convert';

import 'package:flutter/services.dart';

class IconGenerator {
  final reservedKeys = ['class', 'new', 'null', 'sync', 'switch', 'try'];

  // To run this
  main() async {
    Map? iconMap = await _getIconMap();
  }

  // Replace - with _
  // Language reserved words: new -> new_icon
  // Key starts with number: 24_hour -> i_24_hour
  String _sanitizeKey(String key) {
    key = key.replaceAll('-', '_');
    var unsanitizedKey = key;

    if (reservedKeys.contains(key)) {
      key = key + '_icon';
    }

    if (key.startsWith(RegExp('[0-9]'))) {
      key = 'i_' + key;
    }

    if (key != unsanitizedKey) {
      print('converted: $unsanitizedKey -> $key');
    }

    return key;
  }

  Future<Map>? _getIconMap() async {
    final String response =
        await rootBundle.loadString('assets/fonts/remixicon-glyph.json');
    return await json.decode(response);
  }
}
