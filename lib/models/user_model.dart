import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  int? id;
  String? username;
  String? email;
  String? name;
  String? city;
  String? address;
  String? state;
  String? gender;
  int? age;
  String? phoneNumber;

  User({
    this.id,
    this.username,
    this.email,
    this.name,
    this.city,
    this.address,
    this.state,
    this.phoneNumber,
    this.gender,
    this.age,
});

  User.fromJson(Map<String, dynamic> json) {
    id =json["id"];
    username = json["username"];
    email= json["email"];
    name= json["name"];
    city= json["city"];
    state= json["state"];
    phoneNumber= json['phoneNumber'];
    age =json["age"];
    gender=json["gender"];
    gender=json["address"];


  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['phoneNumber'] = phoneNumber;
    data["address"] =address;
    return data;
  }

}


class UserProvider extends ChangeNotifier {
  static late User user=User(name:"guest");
   static void aUser(User user1) {
    user=user1;
    print("user provider");

  }
}