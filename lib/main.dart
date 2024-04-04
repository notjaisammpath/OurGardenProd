import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/pages/home.dart';
import 'package:flutter_walkthrough/pages/myaccountpage.dart';
import 'package:flutter_walkthrough/pages/mycommunitiespage.dart';
import 'package:flutter_walkthrough/pages/onboarding/onboarding.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  

     @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getAppTheme(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: Back4app().hasUserLogged(),
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
                if (snapshot.hasData && snapshot.data!) {
                  return Home(startIndex: 0,);
                } else {
                  return const Onboarding();
                }
            }
          })
    );
  }
}

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Back4app().initialize();
  runApp(
      const MyApp(),
    );
}
