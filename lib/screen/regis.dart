import 'package:agriser_app/screen/Login.dart';
import 'package:agriser_app/utility/dialog.dart';
import 'package:agriser_app/utility/ismethod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String name = "";
  late String tel = "";
  late String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน"),
        backgroundColor: Ismethod().dartcolor,
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
              Passwordform(),
              Ismethod().Space(),
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
            print("กดยืนยัน");
            print(
              "ชื่อ = $name, เบอร์โทร - $tel, รหัสผ่าน = $pass",
            );
            if (tel == null ||
                tel.isEmpty ||
                name == null ||
                name.isEmpty ||
                pass == null ||
                pass.isEmpty) {
              dialong(context, "กรุณากรอกข้อมูลให้ครบทุกช่อง");
              print("กรอกข้อมูลไม่ครบ");
            } else {
              checktel();
            }
          },
          child: Text(
            "ยืนยัน",
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
      registhread();
    } else {
      dialong(context, "เบอร์ $tel ถูกใช้งานแล้ว กรุณาลองใหม่");
    }
  }

  void registhread() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_app/addUser.php?isAdd=true&tel=$tel&pass=$pass&name=$name");
    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Login());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Ismethod().dartcolor),
            labelText: "ชื่อ-นามสกุล",
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
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
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
}
