// user_pain_relief_model.dart
class UserPainReliefResponseModel {
  final String? id;
  final String? userId;
  final String name;
  final String type;
  final String emoji;
  final bool isVisibleInTracker;
  final bool isTrigger;
  final List<String> triggers;
  final String note;

  UserPainReliefResponseModel({
    this.id,
    this.userId,
    required this.name,
    required this.isVisibleInTracker,
    required this.isTrigger,
    required this.triggers,
    required this.note,
    required this.emoji,
    required this.type,
  });

  factory UserPainReliefResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPainReliefResponseModel(
      id: json['id'],
      name: json['name'],
      type: json['type'] ?? '',
      userId: json['userId'] ?? '',
      isVisibleInTracker: json['isVisibleInTracker'],
      isTrigger: json['isTrigger'],
      triggers: List<String>.from(json['triggers'] ?? []),
      note: json['note'] ?? '',
      emoji: json['emoji'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'emoji': emoji,
        'type': type,
        'isVisibleInTracker': isVisibleInTracker,
        'isTrigger': isTrigger,
        'triggers': triggers,
        'note': note,
      };

  UserPainReliefResponseModel copyWith({
    String? userId,
    String? name,
    bool? isVisibleInTracker,
    bool? isTrigger,
    List<String>? triggers,
    String? note,
    String? emoji,
    String? type,
  }) {
    return UserPainReliefResponseModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isVisibleInTracker: isVisibleInTracker ?? this.isVisibleInTracker,
      isTrigger: isTrigger ?? this.isTrigger,
      triggers: triggers ?? this.triggers,
      note: note ?? this.note,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
    );
  }
}
