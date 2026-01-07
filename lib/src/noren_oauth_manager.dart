import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'services/api_provider.dart';
import 'noren_oauth_constants.dart';

class NorenOauthManager {
  late final NorenConstants constants;
  late final NorenApiProvider provider;
  var genAcsTknResp = {};

  NorenOauthManager() {
    final file = File('noren_oauth_config.json');

    if (!file.existsSync()) {
      throw Exception('configuration file not found');
    }
    constants = NorenConstants(jsonDecode(file.readAsStringSync()));
    provider = NorenApiProvider(baseUrl: constants.apiURL);
  }

  Future<dynamic> genAcsTkn({required String code}) async {
    genAcsTknResp = {};
    String param = "${constants.clientId}${constants.secretCode}$code";
    String checksum = "${sha256.convert(utf8.encode(param))}";

    final resp = await provider.post(provider.loginUrl, {
      'code': code,
      'checksum': checksum,
    }, null);
    if (resp['access_token'] != null) {
      genAcsTknResp = resp;
    }
    return resp;
  }

  Future<dynamic> getLimits() async {
    var msg = validate();
    if (msg != '') {
      return {'stat': provider.apiNotOk, 'emsg': msg};
    }
    final resp = await provider.post(provider.lmts, {
      'uid': genAcsTknResp['uid'],
      'actid': genAcsTknResp['actid'],
    }, genAcsTknResp['access_token']);

    return resp;
  }

  String validate() {
    if (genAcsTknResp['access_token'] == null) {
      return 'Access Token Not Found';
    } else if (genAcsTknResp['uid'] == null) {
      return 'User id Not Found';
    } else if (genAcsTknResp['actid'] == null) {
      return 'Account id Not Found';
    }
    return '';
  }
}
