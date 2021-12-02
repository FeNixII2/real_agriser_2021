import 'package:agriser_app/screen/user/calenda_u.dart';
import 'package:agriser_app/screen/user/chat_u.dart';
import 'package:agriser_app/screen/user/search_u.dart';
import 'package:flutter/material.dart';

class Main_u extends StatefulWidget {
  const Main_u({Key? key}) : super(key: key);

  @override
  _Main_uState createState() => _Main_uState();
}

class _Main_uState extends State<Main_u> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("หน้าหลัก"),
      ),
    );
  }
}
