import 'dart:io';

import 'package:agriser_app/utility/ismethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class Addinfo_service extends StatefulWidget {
  const Addinfo_service({Key? key}) : super(key: key);

  @override
  _Addinfo_serviceState createState() => _Addinfo_serviceState();
}

class _Addinfo_serviceState extends State<Addinfo_service> {
  late double lat = 0;
  late double lng = 0;
  File? file;
  File? imageee;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData? locationData = await findlocationData();
    setState(() {
      lat = locationData!.latitude!;
      lng = locationData.longitude!;
    });
    print("lat = $lat, lng = $lng");
  }

  Future<LocationData?> findlocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มข้อมูลการให้บริการ"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Ismethod().Space(),
              price(),
              Ismethod().Space(),
              address(),
              Ismethod().Space(),
              phone(),
              Ismethod().Space(),
              images(),
              Ismethod().Space(),
              IconButton(
                  onPressed: () => pickimage(),
                  icon: Icon(Icons.add_photo_alternate)),
              Ismethod().Space(),
              lng == 0 ? Ismethod().ShowProgress() : showmap(),
              Ismethod().Space(),
              confirm()
            ],
          ),
        ),
      ),
    );
  }

  Future pickimage() async {
    try {
      var imageee = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageee == null) return;
      var imageTemporary = File(imageee.path);
      setState(() => this.imageee = imageTemporary);
    } on PlatformException catch (e) {
      print("ไม่ได้ติดเออเรอ $e");
    }
  }

  // ของมาสเตอร์อึ่งใช้ไม่ได้
  // Future<Null> chooseImage(ImageSource imageSource) async {
  //   try {
  //     print("file new is Hellow");
  //     var object = await ImagePicker().pickImage(
  //       source: imageSource,
  //     );
  //     setState(() {
  //       file = object as File;
  //       print("file new is = $object");
  //     });
  //   } catch (e) {}
  // }

  Set<Marker> myMarker() {
    return <Marker>{
      Marker(
        markerId: MarkerId("ที่อยู่ของฉัน"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: "ที่อยู่ของคุณ",
          snippet: "ละติจูด = $lat, ลองติจูด = $lng",
        ),
      ),
    }.toSet();
  }

  Widget confirm() => Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Colors.green,
        child: Text(
          "ยืนยัน",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ));

  Container showmap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);
    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Container images() {
    return Container(
      width: 250.0,
      child: imageee != null
          ? Image.file(
              imageee!,
              width: 250.0,
              height: 250.0,
              fit: BoxFit.cover,
            )
          : Image.asset("assets/images/photo.png"),
    );
  }

  Widget price() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text("ราคา"),
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      );

  Widget address() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                  label: Text("ที่อยู่"),
                  prefixIcon: Icon(Icons.add_location_alt),
                  border: OutlineInputBorder()),
              maxLines: 4,
            ),
          ),
        ],
      );

  Widget phone() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                  label: Text("เบอร์โทรศัพท์"),
                  prefixIcon: Icon(Icons.contact_phone),
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      );
}
