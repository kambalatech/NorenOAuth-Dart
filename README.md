Noren OAuth Manager

## Features

A lightweight, secure, and platform-agnostic Noren OAuth manager for Dart and Flutter with pluggable storage and production-ready design.

## Getting started

To use this plugin, add `noren_oauth_wrapper` as a dependency in your `pubspec.yaml` file
start using the package.

### Add JSON Config File to Assets
 
Add configuration file to the path `assets/config/noren_oauth_config.json`

```json
{
  "apiURL": "https://api.example.url",
  "clientId": "YOUR_CLIENT_ID",
  "secretCode": "YOUR_SECRET_CODE"
}
```
#### Register Asset in pubspec.yaml

```yaml
flutter:
  assets:
    - assets/config/noren_oauth_config.json
```

## Usage

Import `noren_oauth_wrapper.dart`:

```dart
import 'package:noren_oauth_wrapper/noren_oauth_wrapper.dart';
```
Before you can use this plugin, you need to initialize it by passing loaded `noren_oauth_config.json` 


