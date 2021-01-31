import 'package:flutter/material.dart';

class RestrictedContentView extends StatelessWidget {
  final Color color;

  RestrictedContentView(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }

}