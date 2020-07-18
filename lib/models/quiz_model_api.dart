class QuizResponse {
  int responseCode;
  List<QuizResults> results;

  QuizResponse({this.responseCode, this.results});

  QuizResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = new List<QuizResults>();
      json['results'].forEach((v) {
        results.add(new QuizResults.fromJson(v));
      });
    }
  }
}

class QuizResults {
  String question;
  String correctAnswer;
  List<String> allAnswers;

  QuizResults({this.question, this.correctAnswer, this.allAnswers});

  factory QuizResults.fromJson(Map<String, dynamic> json) {
    return QuizResults(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        allAnswers: parseAnswers(json));
  }

  static List<String> parseAnswers(Map<String, dynamic> json) {
    List<String> options = List<String>();
    options.add(json['correct_answer']);
    options.addAll(List<String>.from(json['incorrect_answers']));
    return options;
  }
}
