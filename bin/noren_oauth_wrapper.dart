import 'package:noren_oauth_wrapper/noren_oauth_wrapper.dart';

void main() async {
  var oauthManager = NorenOauthManager(
    config: {
      "apiURL": "https://rama.kambala.co.in/NorenWClientWeb/",
      "secretCode":
          "iqpr4dqb5A3ZyRbsZ2JScsLJVuDeSglUfFqomyrEWf1tluH43SCDTihC3oJiGTb9",
      "clientId": "TESTINV1_U",
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
