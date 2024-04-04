import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/profileSnippet.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const MyAppBar(heading: "Settings", backbutton: true, searchBar: true,),
        SliverList.list(children: [
          RequestWidget(
            otherUser: User("testUser", "Fakeemail"),
            icon: Icons.abc,
            onPress: () {},
          ),
        ])
      ],
    ));
  }
}

class RequestWidget extends StatelessWidget {
  const RequestWidget({
    Key? key,
    required this.otherUser,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final User otherUser;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

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
                "${otherUser.displayName} is requesting \n a tomato or smt" ,
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
                        children: <Widget>[ProfileSnippet(user: otherUser)],
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
