import 'dart:convert';

import 'package:agriser_app/screen/home.dart';
import 'package:agriser_app/screen/regis.dart';
import 'package:agriser_app/screen/user/buttombar_u.dart';

import 'package:agriser_app/utility/dialog.dart';
import 'package:agriser_app/utility/ismethod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:agriser_app/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String tel = "";
  late String pass = "";
  bool _securetext = true;
  late String usernamelogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  Future<Null> checklogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      usernamelogin = preferences.getString("name")!;
      print("usernamelogin = $usernamelogin");
      if (usernamelogin == null) {
        print("not login ready");
      } else {
        print("login ready");
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => Buttombar_u());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Ismethod().Showlogo(),
              Ismethod().Space(),
              Ismethod().Showapptext("Agriser App"),
              Ismethod().Space(),
              Userform(),
              Ismethod().Space(),
              Passwordform(),
              Loginbutton(),
              Container(
                width: 250.0,
                child: RaisedButton(
                  color: Ismethod().dartcolor,
                  onPressed: () {
                    // MaterialPageRoute route =
                    //     MaterialPageRoute(builder: (value) => Thome());
                    // Navigator.push(context, route);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Register();
                    }));
                  },
                  child: Text(
                    "ลงทะเบียน",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Loginbutton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Ismethod().dartcolor,
          onPressed: () {
            if (tel == null || tel.isEmpty || pass == null || pass.isEmpty) {
              dialong(context, "กรุณากรอกให้ครบทุกช่อง");
            } else {
              checktel();
            }
          },
          child: Text(
            "เข้าสู่ระบบ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  void checktel() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_app/getUserWhereUser.php?isAdd=true&tel=$tel");
    print(response.data);

    if (response.data == "null") {
      dialong(context, "ไม่มีเบอร์ $tel ในระบบ");
    } else {
      var result = json.decode(response.data);

      print(result);
      for (var map in result) {
        Welcome datauser = Welcome.fromJson(map);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("id", datauser.id);
        preferences.setString("tel", datauser.tel);
        preferences.setString("name", datauser.name);

        if (pass == datauser.pass) {
          print("ไปหน้าหลัก");
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => Buttombar_u());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        } else {
          dialong(context, "รหัสผ่านไม่ถูกต้อง");
        }
      }
      print("เข้าสู่ระบบ");
    }
  }

  Widget regisbutton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Ismethod().dartcolor,
          onPressed: () {},
          child: Text(
            "ลงทะเบียน",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget Userform() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => tel = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Ismethod().dartcolor),
            labelText: "เบอร์โทรศัพท์",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Ismethod().dartcolor)),
          ),
        ),
      );

  Widget Passwordform() => Container(
        width: 250.0,
        child: TextField(
          obscureText: _securetext,
          onChanged: (value) => pass = value.trim(),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(_securetext ? Icons.remove_red_eye : Icons.security),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
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
}
