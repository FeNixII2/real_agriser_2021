import 'package:agriser_app/screen/Login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: drawer(),
    );
  }

  Drawer drawer() => Drawer(
        child: ListView(
          children: [
            Showdata(),
            logout(),
          ],
        ),
      );

  ListTile logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),onTap: (){MaterialPageRoute route = MaterialPageRoute(builder: (value)=> Login());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);},
      );

  UserAccountsDrawerHeader Showdata() {
    return UserAccountsDrawerHeader(
        accountName: Text("Username"), accountEmail: Text("Tel"));
  }
}
