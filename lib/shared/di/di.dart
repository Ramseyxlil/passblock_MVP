//
//  password_manager
//  di
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:developer';

import 'package:get_it/get_it.dart';

import 'secure_storage.dart';
import 'storage.dart';

GetIt di = GetIt.instance;

Future<void> setupServices() async {
  log('Registering services...');
  final storageInstance = await StorageService.getInstance();
  final secureStorageInstance = await SecureStorageService.getInstance();

  di
    ..registerSingleton<StorageService>(storageInstance)
    ..registerSingleton<SecureStorageService>(secureStorageInstance);

  log('Services registered: [storage, secure-storage] ✅');
}
