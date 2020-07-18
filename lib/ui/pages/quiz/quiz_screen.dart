import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/bloc/quiz_bloc.dart';
import 'package:quizapp/bloc/quiz_list_event.dart';
import 'package:quizapp/bloc/quiz_list_state.dart';
import 'package:quizapp/repository/quiz_repo.dart';
import 'package:quizapp/ui/pages/quiz/quiz_content.dart';
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
                if (state.quizs.length > 0) {
                  return QuizFullPageScreen(quizs: state.quizs);
                } else {
                  return showErrorWidget("Well, nothing to display!");
                }
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
}
