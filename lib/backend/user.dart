import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User{
  String? displayName;
  String? email;
  String? objectId;
  User(String this.displayName, String this.email){
    objectId = "123456";
  }
  
  User.fromParse(ParseObject p) {
    displayName = p.get("username");
    objectId = p.objectId;
    email = p.get("username");
  }
}