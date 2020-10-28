import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/models/quiz_model_api.dart';
import 'package:quizapp/models/quiz_options.dart';
import 'package:quizapp/utils/exceptions.dart';

class QuizController extends GetxController {

  int currentPage = 1;
  final Rx<List<QuizModel>> _quizs = Rx<List<QuizModel>>();
  List<QuizModel> get quizs => _quizs.value;

  void setCurrentPage(int position) {
    currentPage = ++position;
  }

  bool isFirstPage() => currentPage == 1;

  bool isLastPage() => currentPage == 10;

  // region [API Call]
  Future<List<QuizModel>> getQuiz(QuizOptions options) async {
    final url =
        'https://opentdb.com/api.php?amount=10&category=${options.categoryId}'
        '&difficulty=${options.difficultyId}&type=${options.difficultyId}';
    debugPrint("url -> $url");
    final List<QuizResults> list = List<QuizResults>();
    List<QuizModel> quizResults = List<QuizModel>();
    try {
      int index = 0;
      final response = await http.get(url);
      list.addAll(_parseResponse(response));
      quizResults = list.map((quizResult) => QuizModel(
              index: ++index,
              totalQuestions: list.length,
              question: quizResult.question,
              correctAnswer: quizResult.correctAnswer,
              answerModels: quizResult.allAnswers.mapAndShuffle(),
            ),
          ).toList();
    } on SocketException {
      throw NetworkConnectionException('No internet connection!');
    }
    _quizs.value = quizResults;
    return _quizs.value;
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

  void updateQuizOnSelection(int index) {

  }
}

extension on List<String> {
  List<QuizAnswerModel> mapAndShuffle() {
    List<QuizAnswerModel> answers = List<QuizAnswerModel>();
    answers = this
        .map((option) => QuizAnswerModel(option: option, checkedOption: false))
        .toList();
    answers.shuffle();
    return answers;
  }
}
