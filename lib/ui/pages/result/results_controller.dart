import 'package:get/get.dart';
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/ui/pages/quiz/quiz_controller.dart';

class ResultsController extends GetxController {

  QuizController _quizController = Get.find();

  RxInt _totalQuestions = RxInt();
  int get totalQuestions => _totalQuestions.value;

  RxString _correctlyAnswered = RxString();
  String get correctlyAnswered => _correctlyAnswered.value;

  RxString _outcome = RxString();
  String get outcome => _outcome.value;

  final Rx<List<QuizModel>> _quizs = Rx<List<QuizModel>>();
  List<QuizModel> get quizs => _quizs.value;

  @override
  void onInit() {
    super.onInit();
    
    setWidgetContents();
  }

  void setWidgetContents() {
    _quizs.value = _quizController.quizs;
    int correctAnswers = 0;
    _quizController.quizs.forEach((element) {
      QuizAnswerModel model =
      element.answerModels.firstWhere((element) => element.checkedOption);
      if (element.correctAnswer == model.option) {
        correctAnswers++;
      }
    });
    _outcome.value = _quizResultOutcome(correctAnswers);
    _totalQuestions.value = _quizController.quizs.length;
    _correctlyAnswered.value = "$correctAnswers/${_quizController.quizs.length}";
  }

  String _quizResultOutcome(int correctAnswers) {
    if (correctAnswers > 8) { //9, 10
      return "Excellent";
    } else if (correctAnswers > 5 && correctAnswers <= 8) { // 6..8
      return "Good";
    } else if (correctAnswers >= 3 && correctAnswers <= 5) { // 4..5
      return "Unsatisfactory";
    } else { // Less than or equal to 3
      return "Poor";
    }
  }
}