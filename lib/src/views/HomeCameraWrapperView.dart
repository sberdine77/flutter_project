import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/src/services/AuhtenticationService.dart';
import 'package:flutter_project/src/viewModels/HomeCameraWrapperViewModel.dart';
import 'package:flutter_project/src/views/CameraView.dart';
import 'package:provider/provider.dart';

import 'HomeView.dart';

class HomeCameraWrapperView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeCameraWrapperViewState();
  }
}

class _HomeCameraWrapperViewState extends State<HomeCameraWrapperView> {
  //var _isUserRegistrationFinished = false;
  final _viewModel = HomeCameraWrapperViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(context.read<AuthenticationService>().getCurrentUser().uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        print(snapshot.data.exists);
        if(snapshot.data.exists) {
          return Home();
        } else {
          return CameraView();
        }
      },
    );
  }
}