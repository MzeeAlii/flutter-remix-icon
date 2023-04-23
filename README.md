# Flutter Remix Icon

Remix Icon is a set of open-source neutral-style icons for designers and developers. Currently, contains more than 2400+ icons.

[![icon demo](http://cdn.remixicon.com/preview.svg)](https://remixicon.com)
View the full set of Remix Icons at [remixicon.com](https://remixicon.com).

## Usage

### Installation

Add the `flutter_remix_icon` package to your project dependencies.

```yaml
# pubspec.yaml
dependencies:
    flutter_remix_icon:
        git:
          url: https://github.com/mzeealii/flutter-remix-icon.git

```

>  We are working to publish the package on [pub.dev](https://pub.dev)

Run `pub get` to start using Remix Icon in your Flutter project.

### Using Icons

Import `flutter_remix_icon` package where you would like to use it.

```dart
import 'package:flutter_remix_icon/flutter_remix_icon.dart';

```

Get the icons by using `RemixIcon` class. Its static values return `IconData` which can be wrapped under widgets, such as `Icon`, to be customized and rendered on UI.


```dart
Icon(
  RemixIcon.chat_1_line,
  color: Theme.of(context).accentColor,
  size: 32,
);

```

## License

Remix Icon is licensed under the [Apache License Version 2.0](https://github.com/Remix-Design/remixicon/blob/master/License).  Feel free to use these icons in your projects. It's much appreciated if you mention the original authors of the icons, [Remix Icon](https://remixicon.com), in your product info. Strictly, the icons are not for sale.
