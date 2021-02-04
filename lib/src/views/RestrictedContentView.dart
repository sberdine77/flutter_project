import 'package:flutter/material.dart';
import 'package:flutter_project/src/viewModels/RestrictedContentViewController.dart';
import 'package:loading/loading.dart';
import '../models/Document.dart';

class RestrictedContentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestrictedContentViewState();
  }
}

class _RestrictedContentViewState extends State<RestrictedContentView> {
  //List<Document> _documents = testHomeDocuments;
  var _viewModel = RestrictedContentViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
            child: FutureBuilder<List<Document>>(
              future: _viewModel.getRestrictedDocuments(),
              builder: (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
                //print(snapshot);
                if(snapshot.hasData) {
                  return ListView(
                    children: snapshot.data.map(_buildListItem).toList(),
                  );
                } else {
                  return Loading(size: 100.0,color: Colors.grey);
                }
              },
            )
        )
    );
  }

  Widget _buildListItem(Document document) {
    return new Text(document.name);
  }
}