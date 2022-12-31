import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FileRepository {
  Future<String> registerFile(File file) async {
    String imageUrl = "";
    FirebaseStorage storage = FirebaseStorage.instance;
    String tmp = '${DateTime.now().toUtc()}'.replaceAll(' ', '_');
    Reference storageReference = storage.ref().child("images/image-$tmp");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.then((res) async {
      imageUrl = await res.ref.getDownloadURL();
    });
    return imageUrl;
  }
}