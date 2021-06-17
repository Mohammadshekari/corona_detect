import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String name;
  String gender;
  String number;

  Client({
    this.id,
    this.name,
    this.gender,
    this.number,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    name: json["title"],
    gender: json["gender"],
    number: json["number"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": name,
    "number": number,
    "gender": gender,
  };
}
