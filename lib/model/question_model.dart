import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? text;
  String? response;
  List<String>? options;
  String? theme;
  String? themeImageLink;

  QuestionModel({this.text, this.response, this.options, this.theme, this.themeImageLink});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    response = json['response'];
    options = json['options'].cast<String>();
    theme = json['theme'];
    themeImageLink = json['imageLink'];
  }

  QuestionModel.fromQDS(QueryDocumentSnapshot<Object?> data) {
    text = data['text'];
    response = data['response'];
    options = data['options'].cast<String>();
    theme = data['theme'];
    themeImageLink = data['themeImageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['response'] = this.response;
    data['options'] = this.options;
    data['theme'] = this.theme.toString().toLowerCase();
    data['themeImageLink'] = this.themeImageLink;
    return data;
  }
}