import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizapp/models/quiz_answer_model.dart';

class QuizQuestionAnswerWidget extends StatefulWidget {
  
  final QuizModel model;
  
  QuizQuestionAnswerWidget({this.model});
  
  @override
  _QuizQuestionAnswerWidgetState createState() => _QuizQuestionAnswerWidgetState();
}

class _QuizQuestionAnswerWidgetState extends State<QuizQuestionAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        QuestionWidget(question: widget.model.question),
        SizedBox(height: 15),
        QuizAnswerList(
          correctAnswer: widget.model.correctAnswer,
          answers: widget.model.answerModels,
        )
      ],
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
          color: Colors.white),
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
    widget.answers.shuffle();
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
                element.isCorrect = false;
              });
              widget.answers[index].isCorrect = true;
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
              icon: model.isCorrect
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

