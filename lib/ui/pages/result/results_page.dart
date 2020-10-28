import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/ui/pages/result/results_controller.dart';
import 'package:quizapp/utils/colors.dart';

class ResultsPage extends GetView<ResultsController> {
  static const RESULT_PAGE = '/result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(
          "Result",
          style: TextStyle(fontFamily: 'Monteserrat'),
        ),
        elevation: 5,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.bodyBg,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Obx(() =>
                      Text(
                        "Score: ${controller.correctlyAnswered}",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Monteserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Obx(() =>
                        Text(
                          controller.outcome,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Monteserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.quizs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return resultsItem(controller.quizs[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultsItem(QuizModel quizModel) {
    var selectedOption =
        quizModel.answerModels.firstWhere((element) => element.checkedOption);
    var isCorrect = selectedOption.option == quizModel.correctAnswer;

    return Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: Icon(
              isCorrect ? Icons.check : Icons.close,
              size: 20,
              color: isCorrect ? Colors.green : Colors.red,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  HtmlUnescape().convert(quizModel.question),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monteserrat',
                    color: AppColors.bodyBg,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Correct Answer: ${HtmlUnescape().convert(quizModel.correctAnswer)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Monteserrat',
                    color: AppColors.bodyBg,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !isCorrect,
                  child: Text(
                    "Your Answer: ${HtmlUnescape().convert(selectedOption.option)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Monteserrat',
                      color: AppColors.bodyBg,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
