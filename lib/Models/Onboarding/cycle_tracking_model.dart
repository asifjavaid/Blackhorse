import 'package:ekvi/Utils/helpers/time_helper.dart';

class CycleTrackingModel {
  String? userId;
  String? periodStartDate;
  String? cycleLength;
  String? periodLength;
  String? periodRegularity;
  String? diagnosisTimeframe;

  CycleTrackingModel({this.userId, this.periodStartDate, this.cycleLength, this.periodLength, this.periodRegularity, this.diagnosisTimeframe});

  CycleTrackingModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    periodStartDate = json['periodStartDate'];
    cycleLength = json['cycleLength'];
    periodLength = json['periodLength'];
    periodRegularity = json['periodRegularity'];
    diagnosisTimeframe = json['diagnosisTimeframe'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (periodStartDate != null && periodStartDate!.isNotEmpty) {
      data['periodStartDate'] = periodStartDate;
    }
    if (cycleLength != null && cycleLength!.isNotEmpty) {
      data['cycleLength'] = cycleLength;
    }
    if (periodLength != null && periodLength!.isNotEmpty) {
      data['periodLength'] = periodLength;
    }
    if (periodRegularity != null && periodRegularity!.isNotEmpty) {
      data['periodRegularity'] = periodRegularity;
    }
    if (diagnosisTimeframe != null && diagnosisTimeframe!.isNotEmpty) {
      data['diagnosisTimeframe'] = diagnosisTimeframe;
    }
    data['timezone'] = await TimeHelper.getCurrentTimezone();
    return data;
  }
}

class OboardingUserCycleData {
  String? userId;
  DateTime? periodStartDate;
  String? cycleLength;
  String? periodLength;
  String? periodRegularity;
  String? diagnosisTimeframe;

  OboardingUserCycleData({this.userId, this.periodStartDate, this.cycleLength, this.periodLength, this.periodRegularity, this.diagnosisTimeframe});
}
