//
//  password_manager
//  passwords
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:math';

import '../models/data/password_strength.dart';

String generateRandomPassword({
  int length = 8,
  bool upperCase = true,
  bool lowerCase = true,
  bool number = true,
  bool symbols = true,
}) {
  // Define character sets for different types of characters
  const String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  const String numberChars = '0123456789';
  const String symbolChars = r'!@#$%^&*()_-+=<>?/[]{}|';

  // Combine the character sets based on user preferences
  String allChars = '';
  if (upperCase) allChars += uppercaseChars;
  if (lowerCase) allChars += lowercaseChars;
  if (number) allChars += numberChars;
  if (symbols) allChars += symbolChars;

  // Ensure at least one character type is selected
  if (allChars.isEmpty) {
    throw ArgumentError('At least one character type must be selected.');
  }

  // Generate the random password
  final StringBuffer password = StringBuffer();
  final Random random = Random();
  for (int i = 0; i < length; i++) {
    final int randomIndex = random.nextInt(allChars.length);
    password.write(allChars[randomIndex]);
  }

  return password.toString();
}

PasswordStrength determinePasswordStrength(String password) {
  // Define criteria for password strength
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSymbol = false;
  final bool isLongEnough = password.length >= 8;

  // Check each character in the password
  for (final char in password.runes) {
    final character = String.fromCharCode(char);
    if (RegExp('[A-Z]').hasMatch(character)) {
      hasUppercase = true;
    } else if (RegExp('[a-z]').hasMatch(character)) {
      hasLowercase = true;
    } else if (RegExp('[0-9]').hasMatch(character)) {
      hasNumber = true;
    } else {
      hasSymbol = true;
    }
  }

  // Determine password strength based on criteria
  if (hasUppercase && hasLowercase && hasNumber && hasSymbol && isLongEnough) {
    return PasswordStrength.veryStrong;
  } else if ((hasUppercase || hasLowercase) && hasNumber && isLongEnough) {
    return PasswordStrength.strong;
  } else if ((hasUppercase || hasLowercase) && hasNumber) {
    return PasswordStrength.moderate;
  } else if (isLongEnough) {
    return PasswordStrength.weak;
  } else {
    return PasswordStrength.weak;
  }
}
