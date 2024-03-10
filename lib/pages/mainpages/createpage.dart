import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';

class CreatePage extends StatefulWidget {
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(key: const Key("CREATEPAGESCROLL"), slivers: [
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
  ]);
  }
}