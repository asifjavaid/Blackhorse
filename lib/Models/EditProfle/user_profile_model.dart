class UserProfileModel {
  String? nickName;
  String? lastName;
  String? userName;
  String? email;
  String? fullName;
  String? phonePrefix;
  String? firstName;
  String? gender;
  String? phoneNum;
  String? weight;
  bool? active;
  String? pronoun;
  String? dob;
  String? id;
  String? picLink;
  NotificationPreferences? notificationPreferences;
  // ✅ NEW
  Map<String, bool>? symptomTrackingPreferences;

  UserProfileModel(
      {this.nickName,
      this.lastName,
      this.userName,
      this.email,
      this.fullName,
      this.phonePrefix,
      this.firstName,
      this.gender,
      this.notificationPreferences,
        this.symptomTrackingPreferences,
      this.phoneNum,
      this.weight,
      this.active,
      this.pronoun,
      this.dob,
      this.id,
      this.picLink});

  bool isSymptomEnabled(String key) {
    return symptomTrackingPreferences?[key] == true;
  }

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    notificationPreferences = json['notificationPreferences'] != null ? NotificationPreferences.fromJson(json['notificationPreferences']) : null;
    // ✅ Parse symptomTrackingPreferences
    if (json['symptomTrackingPreferences'] != null) {
      symptomTrackingPreferences =
      Map<String, bool>.from(json['symptomTrackingPreferences']);
    }
    fullName = json['fullName'];
    phonePrefix = json['phonePrefix'];
    firstName = json['firstName'];
    gender = json['gender'];
    phoneNum = json['phoneNum'];
    weight = json['weight'];
    active = json['active'];
    pronoun = json['pronoun'];
    dob = json['dob'];
    id = json['id'];
    picLink = json['picLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastName'] = lastName ?? "";
    data['email'] = email ?? "";
    data['firstName'] = firstName ?? "";
    data['phoneNum'] = phoneNum ?? "";
    data['dob'] = dob ?? "";
    if (notificationPreferences != null) {
      data['notificationPreferences'] = notificationPreferences!.toJson();
    }

    // ✅ Serialize symptomTrackingPreferences
    if (symptomTrackingPreferences != null) {
      data['symptomTrackingPreferences'] =
          symptomTrackingPreferences;
    }

    return data;
  }
}

class NotificationPreferences {
  bool? subscriptionRenewal;
  bool? trialPeriodEnding;
  bool? dailyTrackingReminder;
  String? dailyTrackingReminderTime;

  bool? processDataConsent;  //I consent to Ekvi processing
  bool? shareDataConsent;    //I consent to my anonymized health
  bool? marketingConsent;    //I would like to receive information


  NotificationPreferences({
    this.subscriptionRenewal,
    this.trialPeriodEnding,
    this.dailyTrackingReminder,
    this.dailyTrackingReminderTime,
    this.processDataConsent,
    this.shareDataConsent,
    this.marketingConsent
  });

  NotificationPreferences.fromJson(Map<String, dynamic> json) {
    subscriptionRenewal = json['subscriptionRenewal'];
    trialPeriodEnding = json['trialPeriodEnding'];
    dailyTrackingReminder = json['dailyTrackingReminder'];
    dailyTrackingReminderTime = json['dailyTrackingReminderTime'];

    processDataConsent = json['processDataConsent'];
    shareDataConsent = json['shareDataConsent'];
    marketingConsent = json['marketingConsent'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subscriptionRenewal != null) {
      data['subscriptionRenewal'] = subscriptionRenewal;
    }

    if (trialPeriodEnding != null) {
      data['trialPeriodEnding'] = trialPeriodEnding;
    }

    if (dailyTrackingReminder != null) {
      data['dailyTrackingReminder'] = dailyTrackingReminder;
    }

    if (dailyTrackingReminderTime != null) {
      data['dailyTrackingReminderTime'] = dailyTrackingReminderTime;
    }

    if (processDataConsent != null) {
      data['processDataConsent'] = processDataConsent;
    }

    if (shareDataConsent != null) {
      data['shareDataConsent'] = shareDataConsent;
    }

    if (marketingConsent != null) {
      data['marketingConsent'] = marketingConsent;
    }

    return data;
  }
}
