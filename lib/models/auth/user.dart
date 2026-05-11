class User {
  User({
    this.id,
    this.email,
    this.displayName,
    this.dateOfBirth,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.timezone,
    this.subscriptionTier,
    this.onboardingCompleted,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    displayName = json["display_name"];
    dateOfBirth = json["date_of_birth"];
    gender = json["gender"];
    heightCm = json["height_cm"];
    weightKg = json["weight_kg"];
    timezone = json["timezone"];
    subscriptionTier = json["subscription_tier"];
    onboardingCompleted = json["onboarding_completed"];
  }

  String? id;
  String? email;
  String? displayName;
  String? dateOfBirth;
  String? gender;
  double? heightCm;
  int? weightKg;
  String? timezone;
  String? subscriptionTier;
  bool? onboardingCompleted;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["email"] = email;
    data["display_name"] = displayName;
    data["date_of_birth"] = dateOfBirth;
    data["gender"] = gender;
    data["height_cm"] = heightCm;
    data["weight_kg"] = weightKg;
    data["timezone"] = timezone;
    data["subscription_tier"] = subscriptionTier;
    data["onboarding_completed"] = onboardingCompleted;

    return data;
  }
}
