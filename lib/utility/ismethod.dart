import 'package:flutter/material.dart';

class Ismethod {
  Color dartcolor = Colors.orange.shade200;

  Widget ShowProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SizedBox Space() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text Showapptext(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 22,
          color: Colors.orange.shade200,
          fontWeight: FontWeight.bold,
        ),
      );

  Container Showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset("assets/images/logo.png"),
    );
  }

  Ismethod();
}
