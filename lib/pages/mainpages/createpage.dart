
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_walkthrough/apptheme.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:toggle_switch/toggle_switch.dart';

class CreatePage extends StatefulWidget {
  @override
  State<CreatePage> createState() => _CreatePageState();
}

enum PostType { offer, request, post }

class _CreatePageState extends State<CreatePage> {
  var sliderValue = 0.0;

  PostType postType = PostType.request;
  File? image;

  final _captionController = TextEditingController();

  void clearPhoto() {
    setState(() {
      image = null;
    });
  }

  Future addPostPhoto(BuildContext context) async {
    try {
      final testImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (testImage == null) return;

      final imageTemp = File(testImage.path);

      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print("failed: $e");
    }
  }

  bool validatePost() {
    if (_captionController.text.isNotEmpty) {
      Back4app().createPost(
          _captionController.text,
          image,
          sliderValue,
          postType.toString()
          );
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int postTypeInt;
    switch (postType) {
      case PostType.request:
        postTypeInt = 0;
        break;
      case PostType.offer:
        postTypeInt = 1;
        break;
      case PostType.post:
        postTypeInt = 2;
        break;
    }
    return Scaffold(
      backgroundColor: AppColor.BG_COLOR,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create a Post'),
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ToggleSwitch(
                minWidth: 200,
                animate: false,
                initialLabelIndex: postTypeInt,
                totalSwitches: 3,
                labels: ['Request', 'Offer', 'Post'],
                onToggle: (index) => {
                      if (index == 0)
                        setState(
                          () {postType = PostType.request; postTypeInt = 0;},
                        )
                      else if (index == 1)
                        {
                          setState(
                            () {postType = PostType.offer; postTypeInt = 1;},
                          )
                        }
                      else
                        {
                          setState(
                            () {postType = PostType.post; postTypeInt = 2;},
                          )
                        }
                    }),
          ),
          postType == PostType.post
              ? Expanded(
                  child: Center(
                    child: image == null
                        ? IconButton(
                            onPressed: () => {addPostPhoto(context)},
                            icon: const Icon(Icons.add_photo_alternate_rounded),
                            iconSize: 90,
                          )
                        : Stack(
                            children: [
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                top: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.close),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => AppColor.WHITE)),
                                  onPressed: () => clearPhoto(),
                                ),
                              ),
                            ],
                          ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    image != null
                        ? Stack(
                            children: [
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                top: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.close),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => AppColor.WHITE)),
                                  onPressed: () => clearPhoto(),
                                ),
                              ),
                            ],
                          )
                        : IconButton(
                            onPressed: () => {addPostPhoto(context)},
                            icon: const Icon(Icons.add_photo_alternate_rounded),
                            iconSize: 90,
                          ),
                    Column(
                      children: [
                        postType == PostType.request
                            ? const Text('How many are \nyou requesting?')
                            : const Text("How many are \nyou offering?"),
                        Container(
                          constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                          child: TextField(
                            inputFormatters: [ FilteringTextInputFormatter.digitsOnly,
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
          postType == PostType.request
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Add a plant name",
                      hintText: "What plant are you requesting?",
                    ),
                  ),
                )
              : postType == PostType.offer
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Add a plant name",
                          hintText: "What plant are you requesting?",
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Caption",
                          hintText: "add a caption to your post",
                        ),
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: ElevatedButton(
              onPressed: () => {
                if (validatePost())
                  {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Post Created'),
                      ),
                    )
                  }
                else
                  {}
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
