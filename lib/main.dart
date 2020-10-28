import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/ui/pages/home/home_binding.dart';
import 'package:quizapp/ui/pages/home/home_page.dart';
import 'package:quizapp/ui/pages/quiz/quiz_page.dart';
import 'package:quizapp/ui/pages/result/results_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      defaultTransition: Transition.leftToRight,
      getPages: [
        GetPage(
          name: HomePage.ROOT_PAGE,
          page: () => HomePage(),
          binding: HomeBinding()
        ),
        GetPage(
          name: QuizScreen.QUIZ_PAGE,
          page: () => QuizScreen()
        ),
        GetPage(
          name: ResultsPage.RESULT_PAGE,
          page: () => ResultsPage(),
        ),
      ],
    ),
  );
}
