import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/src/models/Document.dart';

class HomeContentViewModel {
  Future<List<Document>> getHomeDocuments() async {
    List<Document> listToReturn = new List();
    await FirebaseFirestore.instance
        .collection('home')
        .get()
        .then((QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            for(var element in querySnapshot.docs) {
              if (element.data().isNotEmpty) {
                var tempDoc = Document.fromJson(element.data());
                listToReturn.add(tempDoc);
              } else {
                //error in document
              }
            }
          } else {
            //error
          }
        });
    return listToReturn;
  }
}