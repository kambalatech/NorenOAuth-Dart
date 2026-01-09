Noren OAuth Manager

## Features

A lightweight, secure, and platform-agnostic Noren OAuth manager for Dart and Flutter with pluggable storage and production-ready design.

## Getting started

To use this plugin, add `noren_oauth_wrapper` as a dependency in your `pubspec.yaml` file.

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

```dart
 var data = await rootBundle.loadString(
    'assets/config/noren_oauth_config.json',
  );
  var oauthManager = NorenOauthManager(
    config: jsonDecode(data),
    storage: FlutterTokenStorage(),
  );
```

### Sample of FlutterTokenStorage class
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noren_oauth_wrapper/noren_oauth_wrapper.dart';

class FlutterTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _key = 'oauth_token';

  @override
  Future<void> save(String token) async {
    await _storage.write(key: _key, value: token);
  }

  @override
  Future<String?> load() async {
    return await _storage.read(key: _key);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}
```
The optional storage parameter allows the application to persist access tokens securely. If [storage] is not provided, tokens are stored in memory only

