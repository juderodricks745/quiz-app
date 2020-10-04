import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/models/quiz_model_api.dart';
import 'package:quizapp/ui/pages/quiz/quiz_content.dart';
import 'package:quizapp/ui/widgets/common_widgets.dart';
import 'package:quizapp/utils/colors.dart';
import 'package:quizapp/utils/exceptions.dart';

class QuizScreen extends StatelessWidget {
  final String type;
  final String category;
  final String difficulty;

  static const QUIZ_PAGE = '/quiz';

  QuizScreen({this.type, this.category, this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: QuizPage(
        type: type,
        category: category,
        difficulty: difficulty,
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String type;
  final String category;
  final String difficulty;

  QuizPage({this.type, this.category, this.difficulty});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(
          "Quiz",
          style: TextStyle(fontFamily: 'Monteserrat'),
        ),
        elevation: 5,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.bodyBg,
          child: FutureBuilder<List<QuizModel>>(
            future: getQuiz(widget.type, widget.category, widget.difficulty),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return QuizFullPageScreen(quizs: snapshot.data);
              } else if (snapshot.hasError) {
                return showErrorWidget("Well, nothing to display!");
              }
              return showProgressWidget();
            },
          ),
        ),
      ),
    );
  }

  // region [Helper Methods]
  Future<List<QuizModel>> getQuiz(
      String type, String category, String difficulty) async {
    final url =
        'https://opentdb.com/api.php?amount=10&category=$category&difficulty=$difficulty&type=$type';
    final List<QuizResults> list = List<QuizResults>();
    List<QuizModel> models = List<QuizModel>();
    try {
      final response = await http.get(url);
      list.addAll(_parseResponse(response));
      models = list.map(
            (quizResult) =>
            QuizModel(
                question: quizResult.question,
                correctAnswer: quizResult.correctAnswer,
                answerModels: quizResult.allAnswers.mapAndShuffle()
            ),
      ).toList();
    } on SocketException {
      throw NetworkConnectionException('No connection');
    }
    return models;
  }

  List<QuizResults> _parseResponse(http.Response response) {
    List<QuizResults> list = List();
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body.toString());
        list.addAll(QuizResponse.fromJson(responseJson).results);
        break;
      case 400:
      case 401:
      case 403:
      default:
        throw FetchDataException('Something unexpected happened!');
    }
    return list;
  }
  // endregion
}

extension on List<String> {
  List<QuizAnswerModel> mapAndShuffle() {
    List<QuizAnswerModel> answers = List<QuizAnswerModel>();
    answers =
        this.map((option) => QuizAnswerModel(option: option, checkedOption: false)).toList();
    answers.shuffle();
    return answers;
  }
}
