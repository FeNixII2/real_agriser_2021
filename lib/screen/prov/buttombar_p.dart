import 'package:agriser_app/screen/Login.dart';
import 'package:agriser_app/screen/prov/calenda_p.dart';
import 'package:agriser_app/screen/prov/chat_p.dart';
import 'package:agriser_app/screen/prov/main_p.dart';
import 'package:agriser_app/screen/prov/search_p.dart';

import 'package:agriser_app/screen/prov/topbar/info_service_p.dart';
import 'package:agriser_app/screen/user/buttombar_u.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buttombar_p extends StatefulWidget {
  const Buttombar_p({Key? key}) : super(key: key);

  @override
  _Buttombar_pState createState() => _Buttombar_pState();
}

class _Buttombar_pState extends State<Buttombar_p> {
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
    Main_p(),
    Search_p(),
    Calenda_p(),
    Chat_p(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        drawer: drawer(),
        body: _children[_currenIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.red,
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

  Widget drawer() => Container(
        color: Colors.green,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Showdata(),
              edituser(),
              mode(),
              regis_p(),
              // logout(),
            ],
          ),
        ),
      );

  ListTile logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),
        onTap: () {
          checklogout();
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Login());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );

  ListTile mode() => ListTile(
        leading: Icon(Icons.switch_account),
        title: Text("ผู้ใช้ทั่วไป"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Buttombar_u());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );

  ListTile edituser() => ListTile(
        leading: Icon(Icons.personal_injury),
        title: Text("ข้อมูลส่วนตัว"),
        onTap: () {
          // MaterialPageRoute route =
          //     MaterialPageRoute(builder: (value) => Edit_u());
          // Navigator.push(context, route);
        },
      );

  ListTile regis_p() => ListTile(
        leading: Icon(Icons.edit_location),
        title: Text("ข้อมูลการให้บริการ"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Info_service_p());
          Navigator.push(
            context,
            route,
          );
        },
      );

  UserAccountsDrawerHeader Showdata() {
    return UserAccountsDrawerHeader(
        accountName: Text(name_p == null ? 'Main User' : "$name_p"),
        accountEmail: Text(tel_p == null ? 'Main Tel' : "$tel_p"));
  }
}
