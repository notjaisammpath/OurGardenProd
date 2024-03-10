
import 'package:flutter_walkthrough/backend/plantData.dart';

class Plant {
  List<PlantData> data = [];

  Plant({required this.data});

  @override
  String toString() {
    return "${data[0].commonName}";
  }

  Plant.fromJson(Map<String, dynamic> jsonData) {
    data.add(PlantData.fromJson(jsonData));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
//
    return data;
  }
}
