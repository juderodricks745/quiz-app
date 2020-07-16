import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quizapp/models/quiz_model_api.dart';
import 'package:quizapp/utils/exceptions.dart';

abstract class QuizRepo {
  Future<List<QuizResults>> getQuiz(
      String type, String category, String difficulty);
}

class QuizRepoImpl extends QuizRepo {
  @override
  Future<List<QuizResults>> getQuiz(
      String type, String category, String difficulty) async {
    final url =
        'https://opentdb.com/api.php?amount=10&category=$category&difficulty=$difficulty&type=$type';
    final List<QuizResults> list = List<QuizResults>();
    try {
      final response = await http.get(url);
      list.addAll(_parseResponse(response));
    } on SocketException {
      throw NetworkConnectionException('No connection');
    }
    return list;
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
}
