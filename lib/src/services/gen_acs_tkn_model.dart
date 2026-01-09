import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GenAcsTknResp {
  GenAcsTknResp(
    this.userid,
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.scope,
    this.actid,
    this.uname,
    this.lastaccesstime,
    this.uid,
  );

  @JsonKey(name: 'USERID')
  String userid;
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'expires_in')
  String expiresIn;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'scope')
  String scope;
  @JsonKey(name: 'actid')
  String actid;
  @JsonKey(name: 'uname')
  String uname;
  @JsonKey(name: 'lastaccesstime')
  String lastaccesstime;
  @JsonKey(name: 'uid')
  String uid;

  factory GenAcsTknResp.fromJson(Map<String, dynamic> json) => _$FromJson(json);
  Map<String, dynamic> toJson() => _$ToJson(this);
}

Map<String, dynamic> _$ToJson(GenAcsTknResp instance) => <String, dynamic>{
  'access_token': instance.accessToken,
  'USERID': instance.userid,
  'expires_in': instance.expiresIn,
  'refresh_token': instance.refreshToken,
  'scope': instance.scope,
  'actid': instance.actid,
  'uname': instance.uname,
  'lastaccesstime': instance.lastaccesstime,
  'uid': instance.uid,
};

GenAcsTknResp _$FromJson(Map<String, dynamic> json) {
  return GenAcsTknResp(
    json['USERID'] ?? '',
    json['access_token'] ?? '',
    json['expires_in'] ?? "",
    json['refresh_token'] ?? "",
    json['scope'] ?? "",
    json['actid'] ?? "",
    json['uname'] ?? "",
    json['lastaccesstime'] ?? "",
    json['uid'] ?? "",
  );
}
