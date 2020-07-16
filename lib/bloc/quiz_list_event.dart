import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class QuizEvent extends Equatable {}

class FetchQuizListEvent extends QuizEvent {
  final String type;
  final String category;
  final String difficulty;

  FetchQuizListEvent({this.type, @required this.category, this.difficulty});

  @override
  List<Object> get props => [type, category, difficulty];
}
