//
//  password_manager
//  secure_storage
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static SecureStorageService? _instance;
  static FlutterSecureStorage? _storage;

  static Future<SecureStorageService> getInstance() async {
    _instance ??= SecureStorageService();

    _storage ??= const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    return _instance!;
  }

  Future<void> saveToDisk(String key, String content) async {
    log('key: $key value: $content');
    await _storage!.write(key: key, value: content);
  }

  Future<String?> getFromDisk(String key) async {
    final value = await _storage!.read(key: key);
    log('key: $key value: $value');
    return value;
  }

  Future<void> removeFromDisk(String key) async {
    await _storage!.delete(key: key);
    log('Removed $key from secure storage');
  }

  Future<void> clearDisk() async {
    await _storage!.deleteAll();
    log('Cleared secure storage');
  }
}
