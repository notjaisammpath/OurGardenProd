import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/post.dart';

class FeedPage extends StatefulWidget{
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Future<List<Post>> fetchedPosts = Back4app().getUserFeed();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedPosts,
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
          default:
            {
              List<Post> posts = [];
              for(Post k in (snapshot.data as List<dynamic>)) {
                posts.add(k);
              }
              return RefreshIndicator(
                onRefresh: _handleRefresh,
                child: CustomScrollView(
                    key: const Key("GARDENPAGESCROLL"),
                    slivers: [
                      const MyAppBar(heading: "My Garden", searchBar: true, backbutton: false,),
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 4, right: 4, top: 2),
                        sliver: SliverList.list(
                          children: posts,
                        ),
                      ),
                    ]),
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
      fetchedPosts = Back4app().getUserFeed();
    });
  }
}