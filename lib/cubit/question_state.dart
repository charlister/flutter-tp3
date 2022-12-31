part of 'question_cubit.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {
  QuestionInitial();
}

class QuestionLoading extends QuestionState {
  QuestionLoading();
}

class QuestionLoaded extends QuestionState {
  final bool b;
  final List<QuestionModel> questions;

  QuestionLoaded(this.questions, this.b);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionLoaded && other.questions == questions;
  }

  @override
  int get hashCode => questions.hashCode;
}

class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
