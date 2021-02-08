import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;

class FirebaseCommunication {
  Future uploadFile({String uid, File image}) async {
    Reference storageReference = FirebaseStorage.instance.ref().child("selfies/$uid");

    UploadTask task = storageReference.putFile(image);

    await task.whenComplete(() async {
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) async {
        await registerUserData(uid: uid, name: "Example Name");
        await _registerFileUrl(uid: uid, imageUrl: fileURL);
      }).catchError((onError) {
        print(onError);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future registerUserData({String uid, String name}) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({"name": "$name"});
  }

  Future _registerFileUrl({String uid, String imageUrl}) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "image_link": "$imageUrl",
      "registration_finished": true
    });
  }

}