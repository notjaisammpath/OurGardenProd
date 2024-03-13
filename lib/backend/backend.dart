import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/trefle.dart';
import 'package:flutter_walkthrough/widgets/post.dart';

class Backend{
  Future<Map<Plant, int>> getUserPlants()  async{
    var nameList = Back4app().getPlantNames();
    Map<Plant, int> futureMap = {};
    for(String k in nameList) {
      Future<Plant> j = Trefle().getPlantFromName(k.split("--")[0]);
        futureMap[await j] =  int.parse(k.split("--")[1]);
      }
  return futureMap;
  }

}