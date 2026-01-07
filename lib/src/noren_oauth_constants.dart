class NorenConstants {
  late final String apiURL;
  late final String secretCode;
  late final String clientId;
  NorenConstants(dynamic json) {
    if (json['apiURL'] == null) {
      throw Exception('apiURL not found');
    }
    if (json['secretCode'] == null) {
      throw Exception('secretCode not found');
    }
    if (json['clientId'] == null) {
      throw Exception('clientId not found');
    }
    apiURL = json['apiURL'];
    secretCode = json['secretCode'];
    clientId = json['clientId'];
  }
}
