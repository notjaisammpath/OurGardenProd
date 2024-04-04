import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Community{
  String? name;
  String? location;
  String? objectId;
  Community(String this.name, String this.location){
    objectId = "123456";
  }
  Community.fromParse(ParseObject p) {
    name = p.get("name");
    objectId = p.objectId;
    location = p.get("location");
  }
}