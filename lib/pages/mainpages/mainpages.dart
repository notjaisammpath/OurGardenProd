import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/plantView.dart';
import 'package:flutter_walkthrough/widgets/post.dart';

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
  CustomScrollView(key: const Key("GARDENPAGESCROLL"), slivers: [
    const MyAppBar(heading: "My Garden"),
    SliverPadding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 2),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        children: [
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
          PlantView(),
        ],
        
      ),
    ),
  ]),
];
