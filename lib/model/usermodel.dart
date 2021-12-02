import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.id,
    required this.tel,
    required this.pass,
    required this.name,
  });

  String id;
  String tel;
  String pass;
  String name;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        tel: json["tel"],
        pass: json["pass"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tel": tel,
        "pass": pass,
        "name": name,
      };
}
