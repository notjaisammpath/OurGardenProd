import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';

class PlantView extends StatefulWidget{
  const PlantView({super.key});

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  bool _imageLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      color: AppColor.SECONDARY,
      child: Stack(
        children: [
          FutureBuilder<Image>(
          future: Future.delayed(Durations.short1, () {
            setState(() {
              var _imageLoaded = true;
            });
          }
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                );
              default:
                if (snapshot.hasData && snapshot.data!) {
                  return Home(startIndex: 2,);
                } else {
                  return const Onboarding();
                }
            }
          }),
        ],
      )
    );
  }
}