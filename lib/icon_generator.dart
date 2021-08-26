import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:flutter/services.dart';

// class IconGenerator {
final reservedKeys = ['class', 'new', 'null', 'sync', 'switch', 'try'];
final _className = 'RemixIcon';

// To run this
void main() async {
  Map? iconMap = await _getIconMap();

  String fontCode = _buildCode(iconMap);

  _writeCodeToFile(fontCode);
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

// Replace &# with 0, and removing ;
String _sanitizeUnicode(String unicode) {
  unicode = unicode.replaceFirst('&#', '0');
  unicode = unicode.replaceFirst(';', '');
  return unicode;
}

// Extract glyph map from file
Future<Map>? _getIconMap() async {
  print('Reading glyph map file...');
  // final String content =
  //     await rootBundle.loadString('assets/fonts/remixicon-glyph.json');
  String content = '';

  await File('assets/fonts/remixicon-glyph.json')
      .openRead()
      .transform(utf8.decoder)
      .transform(new LineSplitter())
      .forEach((line) => content += line);

  print('Reading glyph map file complete.');

  return await json.decode(content);
}

// Make font class code from glyph map
String _buildCode(Map? iconMap) {
  print('Building code...');
  String code = 'import \'package:flutter/widgets.dart\'; class $_className {';

  iconMap?.forEach((key, value) {
    var _key = _sanitizeKey(key);
    var _unicode = _sanitizeUnicode(value['unicode']);

    code +=
        'static const IconData $_key = IconData($_unicode, fontFamily: "$_className", fontPackage: "flutter_remix_icon");';
  });
  code += "}";
  print('Building code complete.');

  return code;
}

// Write code to local font class file
void _writeCodeToFile(String code) async {
  print('Writing code...');
  final fontFile = '${_className.toLowerCase()}.dart';

  await File('lib/$fontFile')
      .writeAsString(code)
      .then((file) => print('Writing font class code complete.'))
      .onError((error, stackTrace) {
    print('Writing font class code failed!');
  });

  final mainFile = 'flutter_remix_icon.dart';

  code = 'library flutter_remix_icon;'
      'export \'${_className.toLowerCase()}.dart\';';

  await File('lib/$mainFile')
      .writeAsString(code)
      .then((file) => print('Writing main code complete.'))
      .onError((error, stackTrace) {
    print('Writing main code failed!');
  });
}
// }
