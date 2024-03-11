import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/trefle.dart';

class Backend{
  Future<List<Plant>> getUserPlants()  async{
    var nameList = Back4app().getPlantNames();
    List<Future<Plant>> futureList = [];
    for(String k in nameList) {
      Future<Plant> j = Trefle().getPlantFromName(k.split("--")[0]);
      for(int i = 0; i < int.parse(k.split("--")[1]); i++) {
        futureList.add(j);
      }
    }
  return Future.wait(futureList);
  }
}