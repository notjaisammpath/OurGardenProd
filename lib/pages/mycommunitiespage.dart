import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/community.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/profileSnippet.dart';

import 'joincommunitypage.dart';

class MyCommunitiesPage extends StatefulWidget {
  const MyCommunitiesPage({super.key});

  @override
  State<MyCommunitiesPage> createState() => _MyCommunitiesPageState();
}

class _MyCommunitiesPageState extends State<MyCommunitiesPage> {
  Future<List<Community>>? communities;
  TextEditingController communityNameController = TextEditingController(),
      communityLocationController = TextEditingController();
  @override
  void initState() {
    communityLocationController.clear();
    communityNameController.clear();
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
            return const Scaffold(
              body: Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator()),
              ),
            );
          case ConnectionState.none:
            return const Text("error");
          default:
            if (snapshot.hasData) {
              List<CommunityWidget> widgets = [];
              for (Community k in snapshot.data as List<Community>) {
                widgets.add(CommunityWidget(community: k));
              }
              return Scaffold(
                body: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: CustomScrollView(
                    slivers: [
                      const MyAppBar(
                        heading: "Your Communities",
                        backbutton: true,
                        searchBar: false,
                      ),
                      // SliverList.list(children: [
                      //   Padding(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Container(
                      //       constraints: BoxConstraints(minHeight: 50),
                      //       child: Card(
                      //         child: Center(
                      //             child: Text(
                      //           "Your Communities",
                      //           style: Theme.of(context).textTheme.displayLarge,
                      //         ),),
                      //       ),
                      //     ),
                      //   )
                      // ]),
                      SliverPadding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 8, right: 8),
                          sliver: SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: 20 / 9,
                              children: [
                                Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  child: Center(
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.group_rounded),
                                          ),
                                          Text(
                                            "Join A Community",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                        ],
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyCommunitiesPage()),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  child: Center(
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.add_box_rounded),
                                          ),
                                          Text(
                                            "Create A Community",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                        ],
                                      ),
                                      onTap: () async {
                                        communityLocationController.clear();
                                        communityNameController.clear();
                                        await showDialog<void>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: AppColor.BG_COLOR,
                                            content: Container(
                                              constraints: const BoxConstraints(
                                                  minWidth: 400, maxHeight: 200),
                                              color:
                                                  AppColor.BG_COLOR.withAlpha(0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      controller: communityNameController,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .black)),
                                                          labelText:
                                                              'Community Name'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      controller: communityLocationController,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .black)),
                                                          labelText: 'Location'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: TextButton(
                                                        style: Theme.of(context)
                                                            .textButtonTheme
                                                            .style,
                                                        onPressed: () => {
                                                              if (communityNameController.text !="") {
                                                                setState(() {
                                                                  Back4app().addCommunity(Community(
                                                                      communityNameController.text,
                                                                      communityLocationController.text));
                                                                         Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                })
                                                                  
                                                                  }
                                                            },
                                                        child: Text(
                                                          "Create Community",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ])),
                      SliverList.list(children: widgets)
                    ],
                  ),
                ),
              );
            } else
              return const Text("no data in snapshot");
        }
      },
    );
  }
  Future<void> _handleRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration.zero);
    // Update the list of items and refresh the UI
    
    setState(() {
      communities= Back4app().getCommunities();
    });
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
          padding: const EdgeInsets.all(4.0),
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
                      child: const Stack(
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
              icon: const Icon(Icons.delete, color: Colors.redAccent,),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
