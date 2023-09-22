import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phone;
  String? photo;
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
