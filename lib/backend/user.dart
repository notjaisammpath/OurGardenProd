import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User{
  String? displayName;
  String? email;
  String? objectId;
  User(String displayName, String email){
    this.displayName = displayName;
    this.email = email;
    this.objectId = "123456";
  }
  
  User.fromParseObject(ParseObject p) {
    displayName = p.get("username");
    objectId = p.objectId!;
    email = p.get("email");
  }
}