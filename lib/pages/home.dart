import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/pages/mainpages/mainpages.dart';

class Home extends StatefulWidget {
  int startIndex;
  Home({super.key, required this.startIndex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print("current user in home is ${Back4app.currentUser}");
    return Scaffold(
      body: mainPages[widget.startIndex],
      floatingActionButton: widget.startIndex == 2? FloatingActionButton.extended(
        label: const Text("Add a Plant"),
        onPressed: () {
          setState(() {
          });
        },
        elevation: 5,
        foregroundColor: AppColor.PRIMARY,
        backgroundColor: AppColor.WHITE,
        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(10))),
        icon: const Icon(Icons.add),
      ): null,
      backgroundColor: AppColor.BG_COLOR,
      bottomNavigationBar: BottomNavigationBar(
        
        selectedItemColor: AppColor.PRIMARY,
        showUnselectedLabels: false,
        backgroundColor: AppColor.WHITE,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Your Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.create_rounded), label: "Create"),
          BottomNavigationBarItem(icon: Icon(Icons.yard_rounded), label: "Your Garden")
        ],
        currentIndex: widget.startIndex,
        onTap: (value) => setState(() {
          widget.startIndex = value;
        })
      ),
    );
  }
}
