import 'package:flutter/cupertino.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../services/FirebaseCommunication.dart';

class PreviewImageViewModel {
  Future uploadImage({BuildContext context, File image}) async {
    var uid = context.read<AuthenticationService>().getCurrentUser().uid;
    await FirebaseCommunication().uploadFile(uid: uid, image: image);
  }
}