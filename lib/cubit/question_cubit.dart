import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tp3/model/question_model.dart';
import 'package:tp3/repository/question_repository.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  late QuestionRepository questionRepository;

  QuestionCubit() : super(QuestionInitial()) {
    questionRepository = QuestionRepository();
  }

  void reset() {
    emit(QuestionInitial());
  }

  Future<void> displayQuestions() async {
    emit(QuestionLoading());
    try {
      await questionRepository.displayQuestions();
    } on Exception {
      emit(QuestionError("Error displaying questions"));
    }
    emit(QuestionLoaded(const [], true));
  }

  Future<void> getQuestions(String theme) async {
    emit(QuestionLoading());
    try {
      List<QuestionModel> questions = await questionRepository.getQuestions(theme);
      emit(QuestionLoaded(questions, true));
    } on Exception {
      emit(QuestionError("Error getting questions"));
    }
  }
}
