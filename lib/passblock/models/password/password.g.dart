// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) => Password(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      appName: json['appName'] as String?,
      appUrl: json['appUrl'] as String?,
      identifier: json['identifier'] as String?,
      image: json['image'] as String?,
      password: json['password'] as String?,
      passwordStrength: json['passwordStrength'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PasswordToJson(Password instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('appName', instance.appName);
  writeNotNull('appUrl', instance.appUrl);
  writeNotNull('identifier', instance.identifier);
  writeNotNull('image', instance.image);
  writeNotNull('password', instance.password);
  writeNotNull('passwordStrength', instance.passwordStrength);
  writeNotNull('tags', instance.tags);
  return val;
}
