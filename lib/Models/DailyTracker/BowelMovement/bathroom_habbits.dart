class BathroomHabit {
  String? id;
  String? userId;
  DateTime? date;
  String? timeOfDay;
  int? stoolConsistency;
  int? stoolFrequency;
  String? bristolScale;
  List<String>? stoolColour;
  String? stoolSize;
  List<String>? stoolEffort;
  List<String>? stoolComponents;
  String? stoolDuration;
  String? stoolNotes;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? intensity;

  BathroomHabit({
    this.id,
    this.userId,
    this.date,
    this.timeOfDay,
    this.stoolConsistency,
    this.stoolFrequency,
    this.bristolScale,
    this.stoolColour,
    this.stoolSize,
    this.stoolEffort,
    this.stoolComponents,
    this.stoolDuration,
    this.stoolNotes,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.intensity,
  });

  factory BathroomHabit.fromJson(Map<String, dynamic> json) {
    return BathroomHabit(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      timeOfDay: json['timeOfDay'] as String?,
      stoolConsistency: json['stoolConsistency'] as int?,
      stoolFrequency: json['stoolFrequency'] as int?,
      bristolScale: json['bristolScale'] as String?,
      stoolColour: json['stoolColour'] != null ? List<String>.from(json['stoolColour'] as List) : null,
      stoolSize: json['stoolSize'] as String?,
      stoolEffort: json['stoolEffort'] != null ? List<String>.from(json['stoolEffort'] as List) : null,
      stoolComponents: json['stoolComponents'] != null ? List<String>.from(json['stoolComponents'] as List) : null,
      stoolDuration: json['stoolDuration'] as String?,
      stoolNotes: json['stoolNotes'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      type: json['type'] as String?,
      intensity: json['intensity'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date?.toIso8601String(),
      'timeOfDay': timeOfDay,
      'stoolConsistency': stoolConsistency,
      'stoolFrequency': stoolFrequency,
      'bristolScale': bristolScale,
      'stoolColour': stoolColour,
      'stoolSize': stoolSize,
      'stoolEffort': stoolEffort,
      'stoolComponents': stoolComponents,
      'stoolDuration': stoolDuration,
      'stoolNotes': stoolNotes,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'type': type,
      'intensity': intensity,
    };
  }
}
