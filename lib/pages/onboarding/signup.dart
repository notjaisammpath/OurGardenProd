import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: const Text("Continue Creating Your Account"),
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(children: [
                  Padding(
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
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
