import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/user.dart';
import 'package:flutter_walkthrough/pages/mainpages/createpage.dart';

class Post extends StatefulWidget {
  User user;
  Image? image;
  PostType postType;
  String? caption;
  Post( 
      {super.key,
      required this.postType,
      required this.user,
      this.caption,
      this.image}
      );

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) => Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.image ?? const Placeholder(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                child:TextButton(onPressed: () {  },
                child: Text(widget.user.displayName!, style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColor.BLACK),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.caption!, style: Theme.of(context).textTheme.labelMedium!.apply(color: AppColor.BLACK)),
                ),
                
              ],
            ),
          ),
      );
}