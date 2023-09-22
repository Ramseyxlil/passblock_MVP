//
//  password_manager
//  password_strength
//
//  Created by Ngonidzashe Mangudya on 22/08/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

enum PasswordStrength {
  weak('Password is weak'),
  moderate('Password is moderate'),
  strong('Password is strong'),
  veryStrong('Password is very strong');

  const PasswordStrength(this.text);
  final String text;
}
