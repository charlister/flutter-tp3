

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp3/model/theme_model.dart';

class ThemeRepository {
  final CollectionReference themeRef = FirebaseFirestore.instance.collection('theme').withConverter<ThemeModel>(
    fromFirestore: (snapshot, _) => ThemeModel.fromJson(snapshot.data()!),
    toFirestore: (question, _) => question.toJson(),
  );

  Future<List<ThemeModel>> getThemes() async {
    List<ThemeModel> questions = [];
    QuerySnapshot snapshot = await themeRef
        .get();
    for (var doc in snapshot.docs) {
      questions.add(ThemeModel.fromQDS(doc));
    }
    return questions;
  }

  Future<bool> getTheme(String newTheme) async {
    List<ThemeModel> questions = [];
    QuerySnapshot snapshot = await themeRef
        .where('name', isEqualTo: newTheme)
        .get();
    for (var doc in snapshot.docs) {
      questions.add(ThemeModel.fromQDS(doc));
    }
    return questions.isNotEmpty ? true : false;
  }

  Future<void> addTheme(String newTheme, String imageLink) {
    ThemeModel tm = ThemeModel(name: newTheme, imageLink: imageLink);
    return themeRef.add(tm)
    .then((value) => debugPrint("theme data added"))
    .catchError((error) => debugPrint("theme couldn't be added."));
  }
}