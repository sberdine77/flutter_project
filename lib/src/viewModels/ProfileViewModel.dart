import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class ProfileViewModel {
  Future<String> getUserName(BuildContext context) async {
    var user = context.read<AuthenticationService>().getCurrentUser();
    var doc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

    if(doc.exists) {
      if(doc.data().isNotEmpty) {
        if(doc.data()["name"] != null) {
          return doc.data()["name"];
        } else {
          return "No name";
        }
      } else {
        return "No name";
      }
    } else {
      return "No name";
    }
  }

  String getUserEmail(BuildContext context) {
    var user = context.read<AuthenticationService>().getCurrentUser();
    return user.email;
  }

}