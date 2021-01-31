import 'package:flutter/material.dart';
import '../models/Document.dart';

class HomeContentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeContentViewState();
  }
}

class _HomeContentViewState extends State<HomeContentView> {
  List<Document> _documents = testHomeDocuments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new ListView(
          children: _documents.map(_buildListItem).toList(),
        ),
      )
    );
  }

  Widget _buildListItem(Document document) {
    return new Text(document.name);
  }
}