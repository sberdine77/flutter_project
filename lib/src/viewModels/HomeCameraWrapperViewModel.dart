import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:provider/provider.dart';

class HomeCameraWrapperViewModel {
  Future<bool> userRegistrationIsComplete(BuildContext context) async {
    var result = false;
    await FirebaseFirestore.instance.collection("users").doc(context.read<AuthenticationService>().getCurrentUser().uid).get()
        .then((document) {
          if(document.exists) {
            result = true;
          } else {
            result = false;
          }
        })
        .catchError((onError) {
          print(onError);
        });
    return result;
  }
}