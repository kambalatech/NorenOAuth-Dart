import 'package:noren_oauth_wrapper/noren_oauth_wrapper.dart';

void main() async {
  var oauthManager = NorenOauthManager();

  final resp = await oauthManager.genAcsTkn(
    code: 'd5c79e54-e2d7-4502-960b-d0f676a7d7e8',
  );

  print(resp);
  if (resp['stat'] == 'Ok') {
    final resp1 = await oauthManager.getLimits();
    print(resp1);
  }
}
