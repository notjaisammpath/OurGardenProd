import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/trefle.dart';

class Backend{
  Future<List<Plant>> getUserPlants()  async{
    var nameList = Back4app().getPlantNames();
    List<Future<Plant>> futureList = [];
    for(String k in nameList) {
      futureList.add(Trefle().getPlantFromName(k));
    }
  return Future.wait(futureList);
  }
}