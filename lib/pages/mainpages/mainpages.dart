import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/backend.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/pages/mainpages/createpage.dart';
import 'package:flutter_walkthrough/pages/mainpages/feedpage.dart';
import 'package:flutter_walkthrough/widgets/myAppBar.dart';
import 'package:flutter_walkthrough/widgets/plantView.dart';
import 'package:flutter_walkthrough/widgets/post.dart';
class MainPages{


List<Widget> mainPages = [
  //feed page
  FeedPage(),
  //create page
  CreatePage(),
  //my garden page

];
}
