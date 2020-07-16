import 'package:flutter/material.dart';
import 'package:quizapp/ui/pages/home/home_page.dart';
import 'package:quizapp/models/quiz_options.dart';
import 'package:quizapp/ui/pages/quiz/quiz_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case QuizScreen.QUIZ_PAGE:
        if (args is QuizOptions) {
          return MaterialPageRoute(
            builder: (context) => QuizScreen(
              type: args.typeId,
              category: args.categoryId,
              difficulty: args.difficultyId,
            ),
          );
        }
    }
  }
}
