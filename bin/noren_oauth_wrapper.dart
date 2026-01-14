import 'package:noren_oauth_wrapper/noren_oauth_wrapper.dart';

void main() async {
  var oauthManager = NorenOauthManager(
    config: {
      "apiURL": "https://<broker_api_url>/",
      "secretCode": "<secret_code>",
      "clientId": "<client_id>",
    },
  );

  final resp = await oauthManager.genAcsTkn(
    code: '877a8c83-771c-43bc-a436-891f496acda3',
  );

  print(resp);
  if (resp['stat'] == 'Ok') {
    final resp1 = await oauthManager.getLimits();
    print(resp1);
  }
}
