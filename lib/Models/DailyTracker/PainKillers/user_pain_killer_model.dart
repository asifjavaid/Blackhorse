class UserPainKillerResponseModel {
  final String? id;
  final String? userId;
  final String name;
  final String ingredient;
  final int dosage;
  final String dosageEntity;
  final bool isVisibleInTracker;
  final bool isPrescription;
  final bool isTrigger;
  final List<String> triggers;
  final String note;

  UserPainKillerResponseModel({
    this.id,
    this.userId,
    required this.name,
    required this.ingredient,
    required this.dosage,
    required this.dosageEntity,
    required this.isVisibleInTracker,
    required this.isPrescription,
    required this.isTrigger,
    required this.triggers,
    required this.note,
  });

  factory UserPainKillerResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPainKillerResponseModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      ingredient: json['ingredient'],
      dosage: json['dosage'],
      dosageEntity: json['dosageEntity'],
      isVisibleInTracker: json['isVisibleInTracker'],
      isPrescription: json['isPrescription'],
      isTrigger: json['isTrigger'],
      triggers: List<String>.from(json['triggers'] ?? []),
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'ingredient': ingredient,
      'dosage': dosage,
      'dosageEntity': dosageEntity,
      'isVisibleInTracker': isVisibleInTracker,
      'isPrescription': isPrescription,
      'isTrigger': isTrigger,
      'triggers': triggers,
      'note': note,
    };
  }

  UserPainKillerResponseModel copyWith({
    String? userId,
    String? name,
    String? ingredient,
    int? dosage,
    String? dosageEntity,
    bool? isVisibleInTracker,
    bool? isPrescription,
    bool? isTrigger,
    List<String>? triggers,
    String? note,
  }) {
    return UserPainKillerResponseModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      ingredient: ingredient ?? this.ingredient,
      dosage: dosage ?? this.dosage,
      dosageEntity: dosageEntity ?? this.dosageEntity,
      isVisibleInTracker: isVisibleInTracker ?? this.isVisibleInTracker,
      isPrescription: isPrescription ?? this.isPrescription,
      isTrigger: isTrigger ?? this.isTrigger,
      triggers: triggers ?? this.triggers,
      note: note ?? this.note,
    );
  }
}
