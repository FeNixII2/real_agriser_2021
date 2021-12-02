import 'package:agriser_app/screen/prov/topbar/addservice/addinfo_service.dart';
import 'package:flutter/material.dart';

class Info_service_p extends StatefulWidget {
  const Info_service_p({Key? key}) : super(key: key);

  @override
  _Info_service_pState createState() => _Info_service_pState();
}

class _Info_service_pState extends State<Info_service_p> {
  void routeToAdd() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (value) => Addinfo_service());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลการให้บริการ"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [AddAndEdit_service()],
      ),
    );
  }

  Row AddAndEdit_service() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.edit),
                    onPressed: () {
                      print("คลิกเพิ่มรายการ");
                      routeToAdd();
                    }),
              ),
            )
          ],
        )
      ],
    );
  }
}
