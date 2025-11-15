import 'package:ekvi/Utils/helpers/time_helper.dart';

class OnboardingAnswer {
  String? questionId;
  List<String>? answerIds;

  OnboardingAnswer({this.questionId, this.answerIds});

  OnboardingAnswer.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answerIds = json['answerIds'].cast<String>();
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['answerIds'] = answerIds;
    data['timezone'] = await TimeHelper.getCurrentTimezone();
    return data;
  }
}
