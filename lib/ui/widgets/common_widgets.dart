import 'package:flutter/material.dart';

Widget showProgressWidget() {
  return Center(
    child: const CircularProgressIndicator(),
  );
}

Widget showDataWidget() {
  return Center(
    child: Text(
      'Data available!',
      style: TextStyle(
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget showErrorWidget(String error) {
  return Center(
    child: Text(
      'Error $error',
      style: TextStyle(
        fontSize: 20.0,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
