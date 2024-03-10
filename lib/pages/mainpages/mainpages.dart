import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/backend.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/plantView.dart';
import 'package:flutter_walkthrough/widgets/post.dart';
class MainPages{

static Future<List<Plant>> garden = Backend().getUserPlants();

List<Widget> mainPages = [
  //feed page
  CustomScrollView(key: const Key("FEEDPAGESCROLL"), slivers: [
    const MyAppBar(heading: "Feed"),
    SliverList.list(
      children: [
        Post(
          user: User("Jai Sammpath", "jai.sammpath@gmail.com"),
          caption: "THIS IS A CAPTION YAY",
          image: Image.asset('assets/images/ourgarden_logo.jpg'),
          postType: PostType.post,
        ),
        Post(
          user: User("Not Jai Sammpath", "jai.sammpath@gmail.com"),
          caption: "THIS IS A DIFFERENT CAPTION",
          image: Image.asset('assets/images/google_logo.png', fit: BoxFit.fill),
          postType: PostType.post,
        )
      ],
    ),
  ]),
  //create page
  CustomScrollView(key: const Key("CREATEPAGESCROLL"), slivers: [
    const MyAppBar(heading: "Create"),
    SliverGrid.count(
      crossAxisCount: 2,
      children: const [Placeholder(), Placeholder()],
    ),
    SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("$index"),
                ),
            childCount: 10)),
  ]),
  //my garden page

  FutureBuilder(
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
                padding: EdgeInsets.only(left: 8, right: 8, top: 2),
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
      })
];
}
