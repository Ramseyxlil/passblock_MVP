//
//  password_manager
//  extensions
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'package:flutter/material.dart';

extension ContextExtensions<T> on BuildContext {
  Future<T?> goTo({required Widget page}) => Navigator.of(this).push(
        MaterialPageRoute(builder: (_) => page),
      );

  Future<T?> goToAndReplace({required Widget page}) =>
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      );

  Future<T?> goToAndRemoveUntil({required Widget page}) =>
      Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page),
        (route) => false,
      );

  void goBack({dynamic value}) => Navigator.of(this).pop(value);
}
