import 'package:bloc/bloc.dart';
import 'package:quizapp/bloc/quiz_list_event.dart';
import 'package:quizapp/bloc/quiz_list_state.dart';
import 'package:quizapp/models/quiz_model_api.dart';
import 'package:quizapp/repository/quiz_repo.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepoImpl repo;

  QuizBloc(this.repo);

  @override
  QuizState get initialState => QuizLoadingState();

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is FetchQuizListEvent) {
      yield QuizLoadingState();
      try {
        List<QuizResults> list =
            await repo.getQuiz(event.type, event.category, event.difficulty);
        yield QuizLoadedState(quizs: list);
      } catch (e) {
        yield QuizErrorState(errorMessage: '$e');
      }
    }
  }
}
