import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StorageData {
  Future<String> uploadImage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> saveData({
    required String textContent,
    required Uint8List file,
  }) async {
    String resp = "Error Occured";
    try {
      String imageUrl = await uploadImage("create", file);
      await _firestore.collection('post').add({
        'textContent': textContent,
        'createdAt': FieldValue.serverTimestamp(),
        'imageLink': imageUrl
      });
      resp = "success";
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
