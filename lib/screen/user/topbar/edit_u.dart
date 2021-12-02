import 'package:agriser_app/utility/dialog.dart';
import 'package:agriser_app/utility/ismethod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Edit_u extends StatefulWidget {
  const Edit_u({Key? key}) : super(key: key);

  @override
  _Edit_uState createState() => _Edit_uState();
}

class _Edit_uState extends State<Edit_u> {
  String name = "";
  String pass = "";
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูล"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Ismethod().Showlogo(),
              Ismethod().Space(),
              Ismethod().Space(),
              Passwordform(),
              Ismethod().Space(),
              Nameform(),
              Ismethod().Space(),
              addressform(),
              Ismethod().Space(),
              Comfirmbutton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Comfirmbutton() => Container(
        width: 300.0,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {},
          child: Text(
            "ยืนยันแก้ไขข้อมูล",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Colors.blue),
            labelText: "ชื่อ-นามสกุล",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
      );

  Widget addressform() => Container(
        width: 300.0,
        child: TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          maxLines: 5,
          onChanged: (value) => address = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Colors.blue),
            labelText: "ที่อยู่",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
      );

  Widget Passwordform() => Container(
        width: 300.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => pass = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelStyle: TextStyle(color: Colors.blue),
            labelText: "รหัสผ่าน",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
      );
}
