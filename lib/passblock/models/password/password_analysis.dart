class PasswordAnalysis {
  PasswordAnalysis({
    required this.risk,
    required this.weak,
    required this.safe,
    required this.securePercentage,
  });

  int risk;
  int weak;
  int safe;
  int securePercentage;
}
