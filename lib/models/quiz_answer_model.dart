class QuizModel {
  
  String question;
  String correctAnswer;
  List<QuizAnswerModel> answerModels;
  
  QuizModel({this.question, this.correctAnswer, this.answerModels});
}

class QuizAnswerModel {

  String option;
  bool checkedOption;

  QuizAnswerModel({this.option, this.checkedOption});
}