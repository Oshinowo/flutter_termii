# Flutter Termii

<p>
    <img title="Termii" src="https://termii.com/assets/images/logo.png"/>
</p>

[![pub package](https://img.shields.io/pub/v/flutter_termii.svg)](https://pub.dev/packages/flutter_termii)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

---

A Flutter plugin that helps developers use messaging channels to verify and authenticate customer transactions

|             | Android | iOS  | Linux | macOS  | Web | Windows     |
|-------------|---------|------|-------|--------|-----|-------------|
| **Support** | Any     | Any  | Any   | Any    | Any | Any         |

## Features

Use this plugin in your Flutter app to:

- Send message
- Send Bulk message
- Send Token
- Send Voice Token
- Voice Call
- Generate In-App Token
- Verify Token
- View Balance

## Getting started

In order to use Termii's APIs, you need to first create an account for free at [www.termii.com](https://termii.com/).

### BASE URL

Your Termii account has its own Base URL, which you should use in all API requests.
The base URL shown below is a sample base URL. Your base URL can be found on your [dashboard](https://accounts.termii.com/#/).

### Retrieving your API Key

Your API key can be obtained from your [dashboard settings](https://accounts.termii.com/#/account/api).

## Usage

To use this plugin, add `flutter_termii` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_termii:
```

```dart
import 'package:flutter/material.dart';
import 'package:flutter_termii/flutter_termii.dart';

final termii = Termii(
  url: 'https://api.ng.termii.com',
  apiKey: 'YOUR API KEY',
  senderId: 'CompanyName',
);

final responseData = await termii.sendSms(
  destination: "2349012672787",
  message: "This is a test message",
);

print(responseData);
```

## Credits

Developed with 💙 by [Abdulazeez Oshinowo](https://github.com/Oshinowo/)

## License

The MIT License (MIT). Please see [License File](https://github.com/Oshinowo/flutter_termii/blob/main/LICENSE) for more information.

## Additional information

Termii helps deliver great customer messaging experience. You can deep dive into the [full API Reference Documentation](https://developers.termii.com/) to seamlessly integrate it's messaging channels and verification functionalities into your product.
