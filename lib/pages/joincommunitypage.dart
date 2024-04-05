import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/community.dart';
import 'package:flutter_walkthrough/pages/mycommunitiespage.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';

class JoinCommunityPage extends StatelessWidget{
  const JoinCommunityPage({super.key});
  
  @override
  Widget build(BuildContext context) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    const MyAppBar(
                      heading: "Your Communities",
                      backbutton: true,
                      searchBar: false,
                    ),
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
                                              const JoinCommunityPage()),
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
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyCommunitiesPage()),
                                    ),
                                  ),
                                ),
                              )
                            ]
                        )
                        )]));
  }
  }