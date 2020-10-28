import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizapp/models/quiz_answer_model.dart';
import 'package:quizapp/models/quiz_options.dart';
import 'package:quizapp/ui/pages/quiz/quiz_controller.dart';
import 'package:quizapp/ui/pages/result/results_page.dart';
import 'package:quizapp/ui/pages/result/results_binding.dart';
import 'package:quizapp/ui/widgets/common_widgets.dart';
import 'package:quizapp/utils/colors.dart';

class QuizScreen extends GetView<QuizController> {
  static const QUIZ_PAGE = '/quiz';

  final PageController _controller = PageController(initialPage: 0,
      viewportFraction: 1.1);

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
            future: controller.getQuiz(Get.arguments as QuizOptions),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return quizScreenPageView(snapshot.data);
                } else {
                  return showErrorWidget(
                      "No Quiz's for this section, please go back & try different section!");
                }
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

  Widget quizScreenPageView(List<QuizModel> quizs) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: PageView.builder(
        itemBuilder: (context, position) {
          return questionAnswerSection(quizs[position]);
        },
        itemCount: quizs.length,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          controller.setCurrentPage(page);
        },
      ),
    );
  }

  Widget questionAnswerSection(QuizModel model) {

    return FractionallySizedBox(
      widthFactor: 1 / _controller.viewportFraction,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          _questionNumberWidget(model),
          SizedBox(height: 20),
          QuestionWidget(question: model.question),
          SizedBox(height: 15),
          QuizAnswerList(
            correctAnswer: model.correctAnswer,
            answers: model.answerModels,
          ),
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

  Widget _questionNumberWidget(QuizModel model) {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: "Question ${model.index}",
              style: TextStyle(
                color: AppColors.specialColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monteserrat',
              ),
              children: [
                TextSpan(
                  text: "/${model.totalQuestions}",
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
            if (controller.isFirstPage()) {
              Get.snackbar(null, "You've reached first page!", colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
              return;
            }
            _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
        ),
        AppButton(
          text: "Next",
          handler: () {
            if (controller.isLastPage()) {
              _toResults();
            } else {
              _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
            }
          },
        )
      ],
    );
  }

  void _toResults() {
    Get.off(
      ResultsPage(),
      binding: ResultsBinding()
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final String question;

  const QuestionWidget({this.question});

  @override
  Widget build(BuildContext context) {
    return Text(
      HtmlUnescape().convert(question),
      style: TextStyle(
        fontFamily: 'Monteserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class QuizAnswerList extends StatefulWidget {
  final String correctAnswer;
  final List<QuizAnswerModel> answers;

  const QuizAnswerList({this.correctAnswer, this.answers});

  @override
  _QuizAnswerListState createState() => _QuizAnswerListState();
}

class _QuizAnswerListState extends State<QuizAnswerList> {
  @override
  void initState() {
    // widget.answers.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.answers.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.answers.forEach((element) {
                element.checkedOption = false;
              });
              widget.answers[index].checkedOption = true;
            });
          },
          child: AnswerWidget(model: widget.answers[index]),
        );
      },
    );
  }
}

class AnswerWidget extends StatelessWidget {
  final QuizAnswerModel model;

  AnswerWidget({this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Text(
                  HtmlUnescape().convert(model.option),
                  style: TextStyle(
                    fontFamily: 'Monteserrat',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
              // Use the EvaIcons class for the IconData
              icon: model.checkedOption
                  ? Icon(
                      Icons.radio_button_checked,
                      color: Colors.blueAccent,
                    )
                  : Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.white,
                    ),
              onPressed: () {
                // No action to be performed here
              },
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0XFF7981B0),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
