enum PasswordType {
  all('All'),
  social('Social'),
  email('Email'),
  financial('Financial'),
  entertainment('Entertainment'),
  workRelated('Work Related'),
  shopping('Shopping'),
  gaming('Gaming'),
  utilities('Utilities'),
  travel('Travel'),
  healthCare('Health Care'),
  education('Education'),
  personal('Personal'),
  smartDevice('Smart Device'),
  cloudStorage('Cloud Storage'),
  government('Government'),
  other('Other');

  const PasswordType(this.name);
  final String name;
}
