import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'services/aes_gcm.dart';
import 'services/api_provider.dart';
import 'noren_oauth_constants.dart';
import 'services/gen_acs_tkn_model.dart';
import 'services/token_storage.dart';

class NorenOauthManager {
  late final NorenConstants _constants;
  late final NorenApiProvider _provider;
  GenAcsTknResp? _token;
  TokenStorage? _storage;

  /// Manages OAuth authentication and access token lifecycle for Noren APIs.
  ///
  /// `NorenOauthManager` is responsible for:
  /// - Handling OAuth token generation
  /// - Managing access token state
  /// - Optionally persisting tokens using injected storage
  /// - Securely call Noren APIs while maintaining sessions
  ///
  /// The [config] parameter must contain:
  /// - `apiURL` – Base URL of the OAuth server
  /// - `clientId` – OAuth client identifier
  /// - `secretCode` – Client secret code
  ///
  /// The optional [storage] parameter allows the application
  /// to persist access tokens securely.
  ///
  /// If [storage] is not provided, tokens are stored in memory only.
  NorenOauthManager({required Object config, TokenStorage? storage}) {
    _constants = NorenConstants(config);
    _provider = NorenApiProvider(baseUrl: _constants.apiURL);
    _storage = storage;
  }

  /// Generates a new access token using the authorization code.
  ///
  /// On success:
  /// - Updates the in-memory token
  /// - Persists the token if storage is configured
  Future<dynamic> genAcsTkn({required String code}) async {
    _token = null;
    if (_storage != null) {
      await _storage!.clear();
    }
    String param = "${_constants.clientId}${_constants.secretCode}$code";
    String checksum = "${sha256.convert(utf8.encode(param))}";

    final resp = await _provider.post(_provider.loginUrl, {
      'code': code,
      'checksum': checksum,
    }, null);
    if (resp['access_token'] != null) {
      _token = .fromJson(resp);
      if (_storage != null) {
        final aes = AESGCM();
        _storage!.save(aes.encrypt(jsonEncode(_token!.toJson())));
      }
    }
    return resp;
  }

  /// On success returns user fund details
  Future<dynamic> getLimits() async {
    var msg = await _validate();
    if (msg != '') {
      return {'stat': _provider.apiNotOk, 'emsg': msg};
    }
    final resp = await _provider.post(_provider.lmts, {
      'uid': _token!.uid,
      'actid': _token!.actid,
    }, _token!.accessToken);

    return resp;
  }

  Future<String> _validate() async {
    if (_token == null) {
      if (_storage != null) {
        final data = await _storage!.load();
        if (data != null) {
          final aes = AESGCM();
          _token = GenAcsTknResp.fromJson(jsonDecode(aes.decrypt(data)));
        }
      }
    }
    if (_token!.accessToken == '') {
      return 'Access Token Not Found';
    } else if (_token!.uid == '') {
      return 'User id Not Found';
    } else if (_token!.actid == '') {
      return 'Account id Not Found';
    }
    return '';
  }
}
