import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/post.dart';

class FeedPage extends StatefulWidget{
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(key: const Key("FEEDPAGESCROLL"), slivers: [
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
  ],);
  }
}