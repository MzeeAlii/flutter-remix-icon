import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class IconGenerator {
  final reservedKeys = ['class', 'new', 'null', 'sync', 'switch', 'try'];
  final _className = 'RemixIcon';

  // To run this
  main() async {
    Map? iconMap = await _getIconMap();

    String fontCode = _buildCode(iconMap);

    // final filename = 'file.dart';
    // var file = await File(filename).writeAsString(code);
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

  // Replace &# with 0
  String _sanitizeUnicode(String unicode) {
    return unicode.replaceFirst('&#', '0');
  }

  Future<Map>? _getIconMap() async {
    final String response =
        await rootBundle.loadString('assets/fonts/remixicon-glyph.json');
    return await json.decode(response);
  }

  String _buildCode(Map? iconMap) {
    print('Building code...');
    String code =
        'import \'package:flutter/widgets.dart\'; class $_className {';

    iconMap?.forEach((key, value) {
      var _key = _sanitizeKey(key);
      var _unicode = _sanitizeUnicode(value['unicode']);

      code +=
          'static const IconData $_key = IconData($_unicode, fontFamily: "$_className", fontPackage: "flutter_remix_icon");';
    });
    code += "}";
    print('Code complete.');

    return code;
  }
}
