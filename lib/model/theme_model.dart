import 'package:cloud_firestore/cloud_firestore.dart';

class ThemeModel {
  String? name;
  String ? imageLink;
  ThemeModel({this.name, this.imageLink});

  ThemeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageLink = json['imageLink'];
  }

  ThemeModel.fromQDS(QueryDocumentSnapshot<Object?> data) {
    name = data['name'];
    imageLink = data['imageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageLink'] = this.imageLink;
    return data;
  }

  ThemeModel.empty() {
    name = "";
    imageLink = "";
  }
}