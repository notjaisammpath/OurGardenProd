import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/pages/home.dart';
import 'package:flutter_walkthrough/pages/onboarding/signup.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4app {
  final keyApplicationId = 'V0X1QSzqbEv5ymU0wWbHD0WlYeotAQMjFoOpDtcO';
  final keyClientKey = 'ePmz9mBKdglIyiJCrt3vVJmaxeJ6tosVFhsiiGSq';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  static ParseUser? currentUser;
  bool isLoggedIn = false;

  dynamic initialize() async {
    return await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, debug: true);
  }

  Future<bool> hasUserLogged() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser!.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser!.logout();
      return false;
    } else {
      return true;
    }
  }

  Future<void> addPlantToGarden(Plant p) async {
    currentUser!.setAdd("plants", p.data[0].commonName!);
    await currentUser!.save();
  }

  void doUserLogout(BuildContext context) async {
    var response = await currentUser!.logout();
    if (response.success) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User was successfully logged out'),
          ),
        );
        currentUser = null;
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout Error: ${response.error!.message}'),
          ),
        );
      }
    }
  }

  Future<bool> doUserLogin(
      String username, String password, BuildContext context) async {
    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      isLoggedIn = true;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  startIndex: 0,
                )),
        (Route<dynamic> route) => false,
      );
      currentUser = user;
    } else {
      isLoggedIn = false;
    }
    return isLoggedIn;
  }

  Future<bool> doUserRegistration(String username, String email,
      String password, BuildContext context) async {
    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
        (Route<dynamic> route) => false,
      );
      currentUser = user;
      return isLoggedIn = true;
    } else {
      return isLoggedIn = false;
    }
  }

  List<String> getPlantNames() {
    List<String> names = [];
    for (dynamic k in currentUser!.get("plants")) {
      names.add(k.toString());
    }
    return names;
  }
}
