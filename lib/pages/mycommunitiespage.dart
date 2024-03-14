import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/profileSnippet.dart';

class MyCommunitiesPage extends StatefulWidget {
  const MyCommunitiesPage({super.key});

  @override
  State<MyCommunitiesPage> createState() => _MyCommunitiesPageState();
}

class _MyCommunitiesPageState extends State<MyCommunitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const MyAppBar(heading: "Your Communities",),
        SliverList.list(children: [
          CommunityWidget(
            communityLocation: "irving",
            communityName: "community!",
          ),
        ])
      ],
    ));
  }
}

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({
    Key? key,
    required this.communityName,
    required this.communityLocation,
  }) : super(key: key);

  final String communityName;
  final String communityLocation;

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
                communityName,
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
            trailing: IconButton(icon: const Icon(Icons.done), onPressed: (){},),
          ),
        ),
      ),
    );
  }
}
