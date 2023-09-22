import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class Password {
  Password({
    this.id,
    this.userId,
    this.appName,
    this.appUrl,
    this.identifier,
    this.image,
    this.password,
    this.passwordStrength,
    this.tags,
  });

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);

  String? id;
  String? userId;
  String? appName;
  String? appUrl;
  String? identifier;
  String? image;
  String? password;
  int? passwordStrength;
  List<String>? tags;

  Map<String, dynamic> toJson() => _$PasswordToJson(this);
}
