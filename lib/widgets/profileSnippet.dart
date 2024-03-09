import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/backend/user.dart';

class ProfileSnippet extends StatefulWidget{
  User user;
  ProfileSnippet({super.key, required this.user});
  @override
  State<ProfileSnippet> createState() => _ProfileSnippetState();
}

class _ProfileSnippetState extends State<ProfileSnippet> {
  @override
  Widget build(BuildContext context) {
    return Card(child: Center(child: ListTile(title: Text(widget.user.displayName),)),);
  }
}