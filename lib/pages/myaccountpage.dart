import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/community.dart';
import 'package:flutter_walkthrough/pages/home.dart';
import 'package:flutter_walkthrough/pages/mycommunitiespage.dart';
import 'package:flutter_walkthrough/pages/onboarding/onboarding.dart';
import 'package:flutter_walkthrough/pages/requestspage.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> inColumn = [
      2 == 2
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://static.thenounproject.com/png/642902-200.png")
                        )
                    )),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                iconSize: 90,
                onPressed: () => {},
                icon: const Icon(Icons.person_rounded),
              ),
            ),
            Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(children: [ Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          Back4app.currentUser!.username!,
                          style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(fontSizeFactor: 1.5, fontWeightDelta: 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 12),
                        child: Text(
                          Back4app.currentUser!.emailAddress!,
                          style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: AppColor.BLACK),
                        ),
                      ),]),
              ),
            ),
     
      const Padding(
        padding: EdgeInsets.only(left:40, right:40, top: 8, bottom:8),
        child: Divider(),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 20 / 7,
            children: [
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.history_rounded),
                    title: Text(
                      "Requests",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RequestsPage()),
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.yard_rounded),
                    title: Text(
                      "Communities",
                      style: Theme.of(context).textTheme.bodyMedium!.apply(fontSizeFactor: .8),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(startIndex: 3,)),
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.edit_rounded),
                    title: Text(
                      "Edit Profile",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () => Back4app().addCommunity(Community("name", "comloc"))
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: ListTile(
                    leading: const Icon(Icons.logout_rounded, color: Colors.red,),
                    
                    title: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.redAccent),
                    ),
                    onTap: (){
                      Back4app().doUserLogout(context);
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Onboarding()),
                    );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextButton(
          onPressed:
              //create a route to send navigator to an about page
              () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Placeholder()),
          ),
          child: Text(
            'About',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text("Your Account"),
      ),
      body: Column(children: inColumn),
    );
  }
}

