
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/community.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/pages/home.dart';
import 'package:flutter_walkthrough/pages/mainpages/createpage.dart';
import 'package:flutter_walkthrough/pages/mycommunitiespage.dart';
import 'package:flutter_walkthrough/pages/onboarding/signup.dart';
import 'package:flutter_walkthrough/widgets/post.dart';
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

  Future<void> addPlantToGarden(Plant p, int numPlants) async {
    currentUser!.setAdd("plants", "${p.data[0].commonName!}--$numPlants");
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
        MaterialPageRoute(builder: (context) => const Signup()),
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

  void createPost(String text, File? image, double sliderValue, String postType) async{
    var newPost = ParseObject('Post')
      ..set("caption", text)
      ..set("dateTime", DateTime.now())
      ..set('type', postType)
      ..set('num', sliderValue)
      ..set("author", currentUser!)
      ..set("communities", await getParseCommunities());
      if(image != null){
        newPost.set("image", ParseFile(File(image.path)));
      }
    ParseResponse response = await newPost.save();
    if(response.success) {
      ParseObject savedPost = response.results!.first;
      currentUser!.addRelation("posts", [savedPost]);
    }
    await currentUser!.save();
  }

  Future<bool> addCommunity(Community community) async{
    var newCommunity = ParseObject("Community")
      ..set("name", community.name)
      ..set("location", community.location)
      ..setAdd("members", currentUser);
    await newCommunity.save();
    currentUser!
    ..addRelation("communities", [newCommunity])
    ..save();
    await currentUser!.save();
    return true;
  }

  Future<List<ParseObject>> getUserFromObjectId(String objectId) async {
     QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery())
        ..whereContains("objectId", objectId);
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<List<Post>> getUserFeed() async {
    List<String> communityIds = [];
    for(Community k in await getCommunities()) {
      communityIds.add(k.objectId!);
    }
    List<ParseObject> posts = [];
    QueryBuilder<ParseObject> postQuery = QueryBuilder<ParseObject>(
      ParseObject('Post'),
    );
    for(String str in communityIds) {
      print("comids - $communityIds");
      postQuery = postQuery..whereEqualTo("communities", "Community");
    }
    // postQuery = postQuery..whereNotEqualTo('author', currentUser!);

    final ParseResponse postresponse = await postQuery.query();
    if (postresponse.success && postresponse.results != null) {
      // print(postresponse.results!.length);
      posts.addAll(postresponse.results as List<ParseObject>);
    } else if (postresponse.results == null) {
      print("no posts found");
    }

    List<Post> results = [];
    for (ParseObject k in posts) {
      PostType type;
      switch (k.get('type')) {
        case "PostType.request":
          type = PostType.request;
          break;
        case "PostType.offer":
          type = PostType.offer;
          break;
        case "PostType.post":
          type = PostType.post;
          break;
        default:
          type = PostType.post;
          print('no post type found');
          break;
      }
      Post l = Post(postType: type, user: User.fromParse((await getUserFromObjectId(k.get("author").objectId))[0]),  imageUrl: k.get<ParseFileBase>("image")?.url, caption: k.get("caption"),);
      results.insert(0, l);
    }
    return results;
  }

  Future<List<ParseObject>> getParseCommunities() async {
    List<ParseObject> parseCommunities = [];
    ParseRelation<ParseObject> list = await currentUser!.get("communities");
    QueryBuilder communityQuery = list.getQuery();
    final ParseResponse communityResponse = await communityQuery.query();
    if (communityResponse.success && communityResponse.results != null) {
      // print(postresponse.results!.length);
      parseCommunities.addAll(communityResponse.results as List<ParseObject>);
    } else if (communityResponse.results == null) {
      print("no posts found");
    }
    return parseCommunities;
  }

  Future<List<Community>> getCommunities() async {
    List<Community> communities = [];
    List<ParseObject> parseCommunities = [];
    ParseRelation<ParseObject> list = await currentUser!.get("communities");
    QueryBuilder communityQuery = list.getQuery();
    final ParseResponse communityResponse = await communityQuery.query();
    if (communityResponse.success && communityResponse.results != null) {
      // print(postresponse.results!.length);
      parseCommunities.addAll(communityResponse.results as List<ParseObject>);
    } else if (communityResponse.results == null) {
      print("no posts found");
    }
    for(ParseObject j in parseCommunities) {
      print("communityside - ${j.objectId}");
      communities.add(Community.fromParse(j));
    }
    return communities;
  }

  Future<void> removePlantFromGarden(Plant? plant, int numPlants) async{
    currentUser!.setRemove("plants", "${plant!.data[0].commonName!}--$numPlants");
    await currentUser!.save();
  }

}
