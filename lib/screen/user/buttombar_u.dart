import 'package:agriser_app/screen/Login.dart';
import 'package:agriser_app/screen/prov/buttombar_p.dart';
import 'package:agriser_app/screen/user/calenda_u.dart';
import 'package:agriser_app/screen/user/chat_u.dart';
import 'package:agriser_app/screen/user/main_u.dart';
import 'package:agriser_app/screen/user/search_u.dart';
import 'package:agriser_app/screen/user/topbar/edit_u.dart';
import 'package:agriser_app/screen/user/topbar/regis_p.dart';
import 'package:agriser_app/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buttombar_u extends StatefulWidget {
  const Buttombar_u({Key? key}) : super(key: key);

  @override
  _Buttombar_uState createState() => _Buttombar_uState();
}

class _Buttombar_uState extends State<Buttombar_u> {
  late String nameuser;
  late String teluser;
  late String name_p;
  late String tel_p;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameuser = preferences.getString('name')!;
      teluser = preferences.getString('tel')!;
      name_p = preferences.getString('name')!;
      tel_p = preferences.getString('tel')!;
    });
  }

  Future<Null> checklogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  int _currenIndex = 0;
  final List<Widget> _children = [
    Main_u(),
    Search_u(),
    Calenda_u(),
    Chat_u(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: _children[_currenIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.green,
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTappedBar,
              currentIndex: _currenIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("หน้าหลัก"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text("ค้นหา"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  title: Text("ตารางงาน"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  title: Text("แชท"),
                ),
              ]),
        ));
  }

  Drawer drawer() => Drawer(
        child: ListView(
          children: [
            Showdata(),
            edituser(),
            mode(),
            regis_p(),
            logout(),
          ],
        ),
      );

  ListTile logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),
        onTap: () {
          Alertlogout();
        },
      );

  ListTile mode() => ListTile(
        leading: Icon(Icons.switch_account),
        title: Text("ผู้ให้บริการ"),
        onTap: () {
          checktelprovider();
        },
      );

  ListTile edituser() => ListTile(
        leading: Icon(Icons.personal_injury),
        title: Text("ข้อมูลส่วนตัว"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Edit_u());
          Navigator.push(context, route);
        },
      );

  ListTile regis_p() => ListTile(
        leading: Icon(Icons.edit_location),
        title: Text("ลงทะเบียนผู้ให้บริการ"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Regis_p());
          Navigator.push(context, route);
        },
      );

  UserAccountsDrawerHeader Showdata() {
    return UserAccountsDrawerHeader(
        accountName: Text(nameuser == null ? 'Main User' : "$nameuser"),
        accountEmail: Text(teluser == null ? 'Main Tel' : "$teluser"));
  }

  void checktelprovider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_app/getProviderWhereUser.php?isAdd=true&tel_p=$tel_p");
    print(response.data);
    if (response.data == "null") {
      dialong(context, "คุณยังไม่ได้ลงทะเบียนผู้ให้บริการ");
    } else {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => Buttombar_p());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ออกจากระบบ', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text(
              'คุณต้องการออกจากระบบใช่หรือไม่',
            ),
            actions: <Widget>[cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('ตกลง'),
      onPressed: () {
        checklogout();
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Login());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
