import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp3/model/question_model.dart';

class QuestionRepository {
  final CollectionReference questionRef = FirebaseFirestore.instance.collection('question').withConverter<QuestionModel>(
    fromFirestore: (snapshot, _) => QuestionModel.fromJson(snapshot.data()!),
    toFirestore: (question, _) => question.toJson(),
  );

  Future<void> displayQuestions() async {
     await questionRef
        .get()
        .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            print(doc["text"]);
            print(doc["response"]);
            print(doc["options"]);
            print(doc["theme"]);
            print(doc["themeImageLink"]);
          }
        });
  }

  Future<List<QuestionModel>> getQuestions(String theme) async {
    List<QuestionModel> questions = [];
    QuerySnapshot snapshot = await questionRef
        .where('theme', isEqualTo: theme)
        .get();
    for (var doc in snapshot.docs) {
      questions.add(QuestionModel.fromQDS(doc));
    }
    return questions;
  }

  Future<void> addQuestion(String question, String response, String newTheme, List<String> responses, String themeImageLink) async {
    QuestionModel qm = QuestionModel(
      text: question,
      response: response,
      theme: newTheme,
      options: responses,
      themeImageLink: themeImageLink
    );
    return await questionRef.add(qm)
    .then((value) => debugPrint("question data added"))
    .catchError((error) => debugPrint("question couldn't be added."));
  }
}