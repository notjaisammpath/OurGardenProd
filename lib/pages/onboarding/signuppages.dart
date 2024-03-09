import 'package:flutter/material.dart';

final List<Widget> pages = [
  //INITIAL PAGE
  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
            Image.asset(
                'assets/images/ourgarden_logo.jpg',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
        const SizedBox(height: 40),
        const Text(
          'Welcome to OurGarden',
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Let's get you set up.",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    const Column(
      
    ),


];

