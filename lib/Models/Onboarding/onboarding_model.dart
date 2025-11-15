class OnboardingModel {
  bool? firstQuestion;
  bool? lastQuestion;
  String? questionId;
  String? header;
  String? type;
  String? selection;
  List<String>? topText;
  List<String>? bottomText;
  String? buttonText;
  List<OnboardingAnswerModel>? answersList;
  int? completedQuestion;
  String? maxProgress;
  List<String>? selectedAnswerIds;
  String? selectedAnswer;

  OnboardingModel(
      {this.firstQuestion,
      this.lastQuestion,
      this.questionId,
      this.header,
      this.type,
      this.selection,
      this.topText,
      this.bottomText,
      this.buttonText,
      this.answersList,
      this.completedQuestion,
      this.maxProgress,
      this.selectedAnswerIds,
      this.selectedAnswer});

  OnboardingModel.fromJson(Map<String, dynamic> json) {
    firstQuestion = json['firstQuestion'];
    lastQuestion = json['lastQuestion'];
    questionId = json['questionId'];
    header = json['header'];
    type = json['type'];
    selection = json['Selection'];
    topText = json['topText'].cast<String>();
    bottomText = json['bottomText'].cast<String>();
    buttonText = json['buttonText'];
    if (json['answersList'] != null) {
      answersList = <OnboardingAnswerModel>[];
      json['answersList'].forEach((v) {
        answersList!.add(OnboardingAnswerModel.fromJson(v));
      });
    }
    completedQuestion = json['completedQuestion'];
    maxProgress = json['maxProgress'];
    selectedAnswerIds = json['selectedAnswerIds'] != null ? json['selectedAnswerIds'].cast<String>() : [];
    selectedAnswer = json['selectedAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstQuestion'] = firstQuestion;
    data['lastQuestion'] = lastQuestion;
    data['questionId'] = questionId;
    data['header'] = header;
    data['type'] = type;
    data['Selection'] = selection;
    data['topText'] = topText;
    data['bottomText'] = bottomText;
    data['buttonText'] = buttonText;
    if (answersList != null) {
      data['answersList'] = answersList!.map((v) => v.toJson()).toList();
    }
    data['completedQuestion'] = completedQuestion;
    data['maxProgress'] = maxProgress;
    data['selectedAnswerIds'] = selectedAnswerIds;
    data['selectedAnswer'] = selectedAnswer;
    return data;
  }
}

class OnboardingAnswerModel {
  String? answerText;
  String? id;
  String? questionId;
  bool selected = false;

  OnboardingAnswerModel({
    this.answerText,
    this.id,
    this.questionId,
  });

  OnboardingAnswerModel.fromJson(Map<String, dynamic> json) {
    answerText = json['answerText'];
    id = json['id'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answerText'] = answerText;
    data['id'] = id;
    data['questionId'] = questionId;
    return data;
  }
}
