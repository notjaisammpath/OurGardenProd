import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/backend.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/plantView.dart';

class MyGardenPage extends StatefulWidget{
  const MyGardenPage({super.key});

  @override
  State<MyGardenPage> createState() => _MyGardenPageState();
}

class _MyGardenPageState extends State<MyGardenPage> {
  Future<List<Plant>> garden = Backend().getUserPlants();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: garden,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator()),
              ),
            );
          default: {
            List<PlantView> views = [];
            for(Plant k in snapshot.data as List<Plant>) {
              views.add(PlantView.fromPlant(k, 1));
            }
            return CustomScrollView(key: const Key("GARDENPAGESCROLL"), slivers: [
              const MyAppBar(heading: "My Garden"),
              SliverPadding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: 200,
                  children: 
                    views
                  ,
                ),
              ),
            ]);
        }
        }
      });
  }
}