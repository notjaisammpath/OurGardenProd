import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/community.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/profileSnippet.dart';

class MyCommunitiesPage extends StatefulWidget {
  const MyCommunitiesPage({super.key});

  @override
  State<MyCommunitiesPage> createState() => _MyCommunitiesPageState();
}

class _MyCommunitiesPageState extends State<MyCommunitiesPage> {
  Future<List<Community>>? communities;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    communities = Back4app().getCommunities();
    return FutureBuilder(
      future: communities,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.waiting):
            return const CircularProgressIndicator();
          case ConnectionState.none:
            return const Text("error");
          default:
          if(snapshot.hasData){
            List<CommunityWidget> widgets = [];
            for(Community k in snapshot.data as List<Community>) {
              widgets.add(CommunityWidget(community: k));
            }
            return Scaffold(
              body: CustomScrollView(slivers: [
                const MyAppBar(
                  heading: "Your Communities",
                  backbutton: true,
                  searchBar: true,
                ),
                SliverList.list(
                  children: widgets
                )
              ],
              ),
            );
          }
          else return Text("no data in snapshot");
        }
      },
    );
  }
}

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({Key? key, required this.community}) : super(key: key);

  final Community community;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 4, bottom: 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: TextButton(
              child: Text(
                community.name!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[Placeholder()],
                      ),
                    ),
                  ),
                );
              },
            ),
            title: Text(community.location!),
            trailing: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
