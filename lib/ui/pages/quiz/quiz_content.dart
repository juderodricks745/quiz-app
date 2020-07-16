import 'package:flutter/material.dart';

class QuizContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _questionWidget(),
          _answerWidget("dd", true)
        ],
      ),
    );
  }

  Widget _questionWidget() {
    return Text(
      "Which of the following bones is not in the leg?",
      style: TextStyle(
          fontFamily: 'Monteserrat',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }

  Widget _answerWidget(String answer, bool answre) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "$answer",
              style: TextStyle(
                fontFamily: 'Monteserrat',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            // Use the EvaIcons class for the IconData
            icon: answre
                ? Icon(
              Icons.radio_button_checked,
              color: Colors.blueAccent,
            )
                : Icon(
              Icons.radio_button_unchecked,
              color: Colors.white,
            ),
            onPressed: () {
              print("Eva Icon heart Pressed");
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
    );
  }
}
