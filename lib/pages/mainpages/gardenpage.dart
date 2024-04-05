import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/backend.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/plantView.dart';

class MyGardenPage extends StatefulWidget {
  MyGardenPage({super.key});
  List<PlantView> views = [];

  @override
  State<MyGardenPage> createState() => _MyGardenPageState();
}

class _MyGardenPageState extends State<MyGardenPage> {
  Future<Map<Plant, int>> garden = Backend().getUserPlants();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: garden,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          widget.views = [];
            return const Scaffold(
              body: Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator()),
              ),
            );
          default:
            {
              for(Plant k in (snapshot.data as Map<Plant, int>).keys) {
                widget.views.add(PlantView.fromPlant(k, (snapshot.data as Map<Plant, int>)[k]!));
              }
              return RefreshIndicator(
                onRefresh: _handleRefresh,
                child: CustomScrollView(
                    key: const Key("GARDENPAGESCROLL"),
                    slivers: [
                      const MyAppBar(heading: "My Garden", backbutton: false, searchBar: true,),
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 4, right: 4, top: 2),
                        sliver: SliverGrid.extent(
                          mainAxisSpacing: 0,
                          maxCrossAxisExtent: 200,
                          children: widget.views,
                        ),
                      ),
                    ],),
              );
            }
        }
      },
    );
    }
    Future<void> _handleRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration.zero);
    // Update the list of items and refresh the UI
    
    setState(() {
      garden = Backend().getUserPlants();
    });
  }
    
}
