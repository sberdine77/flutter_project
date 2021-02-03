import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/src/models/Document.dart';

class HomeContentViewModel {
  Future<List<Document>> getHomeDocuments() async {
    //print("Firestore");
    List<Document> listToReturn = new List();
    await FirebaseFirestore.instance
        .collection('home')
        .get()
        .then((QuerySnapshot querySnapshot) async {
          //print(querySnapshot);
          if (querySnapshot.docs.isNotEmpty) {
            print("TESTE");
            for(var element in querySnapshot.docs) {
              if (element.data().isNotEmpty) {
                //print(element.data());
                var tempDoc = Document.fromJson(element.data());
                //print(tempDoc.name);

                listToReturn.add(tempDoc);
                //print(listToReturn);
              } else {
                //error in document
              }
            }
          } else {
            //error
          }
        });
    print(listToReturn);
    return listToReturn;
  }
}