import 'package:flutter/material.dart';
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/models/quiz_result_item.dart';
import 'package:quizapp/ui/pages/quiz/quiz_question_answer.dart';
import 'package:quizapp/ui/pages/result/results.dart';
import 'package:quizapp/ui/widgets/common_widgets.dart';
import 'package:quizapp/utils/colors.dart';

class QuizFullPageScreen extends StatefulWidget {
  final List<QuizModel> quizs;

  const QuizFullPageScreen({Key key, this.quizs}) : super(key: key);

  @override
  _QuizFullPageScreenState createState() => _QuizFullPageScreenState();
}

class _QuizFullPageScreenState extends State<QuizFullPageScreen> {
  int questionNumber = 0;

  void _nextQuestion() {
    if (questionNumber < widget.quizs.length - 1) {
      setState(() {
        questionNumber++;
      });
    } else {
      _navigateToResults();
    }
  }

  void _previousQuestion() {
    if (questionNumber >= 1) {
      setState(() {
        questionNumber--;
      });
    }
  }

  void _navigateToResults() {
    //List<QuizResult> results = _quizResults();
    Navigator.pushNamed(
      context,
      ResultsPage.RESULT_PAGE,
      arguments: widget.quizs
    );
  }

  List<QuizResult> _quizResults() {
    List<QuizResult> quizResults = List<QuizResult>();
    widget.quizs.map((element) {
      QuizAnswerModel model =
      element.answerModels.firstWhere((element) => element.checkedOption);
      quizResults.add(QuizResult(
          question: element.question,
          correctAnswer: element.correctAnswer,
          yourAnswer: model.option));
    });
    return quizResults;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      child: Column(
        children: <Widget>[
          _timerWidget(),
          SizedBox(height: 20),
          _questionNumberWidget(),
          SizedBox(height: 20),
          QuizQuestionAnswerWidget(model: widget.quizs[questionNumber]),
          SizedBox(height: 15),
          _previousAndNextWidget(),
        ],
      ),
    );
  }

  Widget _timerWidget() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.specialColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0XFFF43660),
            Color(0XFFA84FEB),
          ],
        ),
      ),
    );
  }

  Widget _questionNumberWidget() {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: "Question ${questionNumber + 1}",
              style: TextStyle(
                color: AppColors.specialColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monteserrat',
              ),
              children: [
                TextSpan(
                  text: "/${widget.quizs.length}",
                  style: TextStyle(
                    color: AppColors.specialColor,
                    fontSize: 15,
                    fontFamily: 'Monteserrat',
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _previousAndNextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppButton(
          text: "Previous",
          handler: () {
            _previousQuestion();
          },
        ),
        AppButton(
          text: "Next",
          handler: () {
            _nextQuestion();
          },
        )
      ],
    );
  }
}
