import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/pages/myaccountpage.dart';

class MyAppBar extends StatelessWidget {
  final String heading;
  final void Function(String)? onSearchFocus;
  const MyAppBar({super.key, required this.heading, this.onSearchFocus});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 65,
      centerTitle: false,
      floating: true,
      title: heading == "Create"? Text(heading) : null,
      automaticallyImplyLeading: false,
      leading: heading == "Create"? null : heading == "Settings"? Transform.translate(offset: const Offset(-70, 0), child: IconButton(onPressed: () => {Navigator.pop(context)}, icon: const Icon(Icons.arrow_back), )): const Padding(
        padding: EdgeInsets.all(10.0),
        child: SearchBar(
        onChanged: null,
        hintText: "Search",
        leading: Icon(Icons.search_rounded),
        elevation: MaterialStatePropertyAll(1),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
        backgroundColor: MaterialStatePropertyAll(AppColor.WHITE),
        ),
      ),
      leadingWidth: 200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
      ),
      actions: [
       
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 12.0),
        
              child:TextButton(
                  style: ButtonStyle( surfaceTintColor: const MaterialStatePropertyAll(AppColor.WHITE), padding: const MaterialStatePropertyAll(EdgeInsets.all(0)), alignment: Alignment.center, iconColor: MaterialStateProperty.all(AppColor.PRIMARY), ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const MyAccountPage(),
                  ),);
                  },
                  child: Column (
                  children: [const Icon(Icons.account_circle, size: 20), Text(Back4app.currentUser!.username!, style: const TextStyle(color: AppColor.PRIMARY),),],
                  )


              ),
       
        )
      ],
    );
  }
}
