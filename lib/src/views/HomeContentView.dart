import 'package:flutter/material.dart';
import 'package:flutter_project/src/viewModels/HomeContentViewModel.dart';
import 'package:loading/loading.dart';
import '../models/Document.dart';

class HomeContentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeContentViewState();
  }
}

class _HomeContentViewState extends State<HomeContentView> {
  //List<Document> _documents = testHomeDocuments;
  var _viewModel = HomeContentViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: FutureBuilder<List<Document>>(
          future: _viewModel.getHomeDocuments(),
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