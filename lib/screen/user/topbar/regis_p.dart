import 'package:agriser_app/screen/user/buttombar_u.dart';
import 'package:agriser_app/utility/dialog.dart';
import 'package:agriser_app/utility/ismethod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Regis_p extends StatefulWidget {
  const Regis_p({Key? key}) : super(key: key);

  @override
  _Regis_pState createState() => _Regis_pState();
}

class _Regis_pState extends State<Regis_p> {
  late String name_p = "";
  late String tel_p = "";
  late String pass = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name_p = preferences.getString('name')!;
      tel_p = preferences.getString('tel')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน"),
        backgroundColor: Colors.blue,
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
              Telform(),
              Ismethod().Space(),
              // Passwordform(),
              // Ismethod().Space(),
              Nameform(),
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
          color: Ismethod().dartcolor,
          onPressed: () {
            Alertlogout();
          },
          child: Text(
            "ยืนยันการลงทะเบียน",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  void checktelprovider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_app/getProviderWhereUser.php?isAdd=true&tel_p=$tel_p");
    print(response.data);
    if (response.data == "null") {
      registhread();
    } else {
      Navigator.of(context).pop();
      dialong(context, "คุณได้สมัครผู้ให้บริการไปแล้ว");
    }
  }

  void registhread() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_app/addProvider.php?isAdd=true&tel_p=$tel_p&name_p=$name_p");
    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => Buttombar_u());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          enabled: false,
          onChanged: (value) => name_p = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Ismethod().dartcolor),
            labelText: "$name_p",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
          ),
        ),
      );

  Widget Telform() => Container(
        width: 300.0,
        child: TextField(
          enabled: false,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          onChanged: (value) => tel_p = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Ismethod().dartcolor),
            labelText: "$tel_p",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
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
            labelStyle: TextStyle(color: Ismethod().dartcolor),
            labelText: "รหัสผ่าน",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
          ),
        ),
      );

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ลงทะเบียนผู้ให้บริการ'),
            content: Text(
              'เมื่อคุณลงทะเบียนผู้ให้บริการ จะสามารถเข้าใช้ฟังก์ชั่นผู้ให้บริการได้เพื่อทำการติดต่อกับผู้ใช้ทั่วไป',
            ),
            actions: <Widget>[cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('ยืนยัน'),
      onPressed: () {
        checktelprovider();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('ยกเลิก'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
