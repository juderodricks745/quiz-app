class QuizModel {

  int index;
  int totalQuestions;
  String question;
  String correctAnswer;
  List<QuizAnswerModel> answerModels;
  
  QuizModel({this.index, this.totalQuestions, this.question, this.correctAnswer, this.answerModels});
}

class QuizAnswerModel {

  String option;
  bool checkedOption = false;

  QuizAnswerModel({this.option, this.checkedOption = false});
}