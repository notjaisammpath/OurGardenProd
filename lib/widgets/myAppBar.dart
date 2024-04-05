import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/pages/myaccountpage.dart';

class MyAppBar extends StatelessWidget {
  final String heading;
  final void Function(String)? onSearchFocus;
  final bool backbutton, searchBar;

  const MyAppBar({super.key, required this.heading, this.onSearchFocus, required this.backbutton, required this.searchBar});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 65,
      leadingWidth: (!backbutton && searchBar)? 200 : null,
      leading: backbutton? null: searchBar? const Padding(
        padding: EdgeInsets.only(top: 6.0, bottom : 6.0, left : 20),
        child: MySearchBar())
                :const Padding(padding: EdgeInsets.all(0)),
      title: searchBar? backbutton?
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MySearchBar()
                  
                ):null :Text(heading),
                actions: [
                  Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 12.0),
          child: TextButton(
              style: ButtonStyle(
                surfaceTintColor:
                    const MaterialStatePropertyAll(AppColor.WHITE),
                padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                alignment: Alignment.center,
                iconColor: MaterialStateProperty.all(AppColor.PRIMARY),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyAccountPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Icon(Icons.account_circle, size: 20),
                  Text(
                    Back4app.currentUser!.username!,
                    style: const TextStyle(color: AppColor.PRIMARY),
                  ),
                ],
              )),
        )
                ],

    );
  }}

  class MySearchBar extends StatelessWidget{
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
          textStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.bodyLarge!.apply(color: AppColor.BLACK)),
                      onChanged: null,
                      hintStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.bodyLarge!.apply(color: AppColor.BLACK.withOpacity(.6))),
                      hintText: "Search",
                      leading: const Icon(Icons.search_rounded),
                      elevation: const MaterialStatePropertyAll(1),
                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      backgroundColor: const MaterialStatePropertyAll(AppColor.WHITE),
                    );
      
  }

  }