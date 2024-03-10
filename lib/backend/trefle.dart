import 'dart:convert';

import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:http/http.dart' as http;

class Trefle{
  static const trefleKey = "_ctQgnSfYAcDzBnanrId6PtDP_tteSElYue0uv6SILY";

  Future<List<Plant>> getGarden() async {
    List<String> ids = await Back4app().getPlantNames();
    List<Plant> garden = [];
    List<String> excRepeats = [];
    for (String k in ids) {
      if (!excRepeats.contains(k)) {
        excRepeats.add(k);
      }
    }
    try {
      for (String k in excRepeats) {
        Plant p = (await getPlantList('common_name', k)).first;
        if (p.data[0].commonName != "null") garden.add(p);
      }
    } catch (e) {
      print('couldnt find plant lmao');
    }

    return garden;
  }

  Future<Plant> getPlantFromName(String name) async {
    return (await getPlantList("common_name", name)).first;
  }

  Future<List<Plant>> getPlantList(String search, String term) async {
    List<Plant> results = [];
    String url = 'https://trefle.io/api/v1/plants?token=$trefleKey';
    switch (search) {
      case "id":
        url += '&filter[id]=$term';
        break;
      case "common_name":
        url += '&filter[common_name]=$term';
        break;
      case "slug":
        url += '&filter[slug]=$term';
        break;
    }

    print(url);

    Map<String, String> header = {"Content-type": "application/json"};
    // make GET request
    var response = await http.get(Uri.parse(url), headers: header);
    // check the status code for the result
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = json.decode(response.body);
      if (parsedJson['data'] != null) {
        parsedJson['data'].forEach((v) {
          results.add(Plant.fromJson(v));
        });
      }
      return results;
    } else {
      return [];
    }
  }
}