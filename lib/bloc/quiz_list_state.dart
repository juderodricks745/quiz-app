import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:quizapp/models/quiz_model_api.dart';

abstract class QuizState extends Equatable {}

class QuizLoadingState extends QuizState {
  @override
  List<Object> get props => [];
}

@immutable
class QuizLoadedState extends QuizState {
  final List<QuizResults> quizs;

  QuizLoadedState({@required this.quizs});

  @override
  List<Object> get props => [quizs];
}

@immutable
class QuizErrorState extends QuizState {
  final String errorMessage;

  QuizErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}