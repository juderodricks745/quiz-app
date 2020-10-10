import 'package:flutter/material.dart';
import 'package:quizapp/utils/colors.dart';

Widget showProgressWidget() {
  return Center(
    child: const CircularProgressIndicator(),
  );
}

Widget showErrorWidget(String error) {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        '$error',
        style: TextStyle(
            fontSize: 18.0, fontFamily: 'Monteserrat', color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class AppButton extends StatelessWidget {
  final String text;
  final Function() handler;

  AppButton({this.text, this.handler});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          handler.call();
        },
        color: AppColors.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Monteserrat',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
