import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/bloc/quiz_bloc.dart';
import 'package:quizapp/bloc/quiz_list_event.dart';
import 'package:quizapp/bloc/quiz_list_state.dart';
import 'package:quizapp/repository/quiz_repo.dart';
import 'package:quizapp/ui/widgets/common_widgets.dart';
import 'package:quizapp/utils/colors.dart';

class QuizScreen extends StatelessWidget {
  final String type;
  final String category;
  final String difficulty;

  static const QUIZ_PAGE = '/quiz';

  QuizScreen({this.type, this.category, this.difficulty});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) => QuizBloc(
        QuizRepoImpl(),
      ),
      child: QuizPage(
        type: type,
        category: category,
        difficulty: difficulty,
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String type;
  final String category;
  final String difficulty;

  QuizPage({this.type, this.category, this.difficulty});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBloc _quizBloc;

  @override
  void initState() {
    super.initState();
    _quizBloc = BlocProvider.of<QuizBloc>(context);
    _quizBloc.add(FetchQuizListEvent(
      type: widget.type,
      category: widget.category,
      difficulty: widget.difficulty,
    ));
  }

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
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizLoadingState) {
                return showProgressWidget();
              } else if (state is QuizLoadedState) {
                return showDataWidget();
              } else if (state is QuizErrorState) {
                return showErrorWidget(state.errorMessage);
              }
              return showProgressWidget();
            },
          ),
        ),
      ),
    );
  }

  Widget _timerWidget() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0XFF777FAD),
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

  Widget _questionNumberWidget() {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: "Question 1",
              style: TextStyle(
                color: Color(0XFF7981B0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monteserrat',
              ),
              children: [
                TextSpan(
                  text: "/10",
                  style: TextStyle(
                    color: Color(0XFF7981B0),
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
        _buttonPreviousAndNext("Previous"),
        _buttonPreviousAndNext("Next"),
      ],
    );
  }

  Widget _buttonPreviousAndNext(String text) {
    return Container(
      width: 140,
      height: 50,
      child: RaisedButton(
        onPressed: () => {},
        color: AppColors.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Text(
          "$text",
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
