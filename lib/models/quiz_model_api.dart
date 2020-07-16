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
  List<String> incorrectAnswers;

  QuizResults({this.question, this.correctAnswer, this.incorrectAnswers});

  factory QuizResults.fromJson(Map<String, dynamic> json) {
    return QuizResults(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: parseIncorrectAnswers(json['incorrect_answers']));
  }

  static List<String> parseIncorrectAnswers(incorrectOptions) {
    List<String> options = new List<String>.from(incorrectOptions);
    return options;
  }
}
