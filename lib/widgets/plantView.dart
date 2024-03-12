import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/apptheme.dart';

import '../../backend/plant.dart';

// ignore: must_be_immutable
class PlantView extends StatefulWidget {
  String name = "PLANT_NAME";
  String imageUrl = "https://cdn-icons-png.flaticon.com/512/628/628283.png";
  int numOfPlants = 1;
  Plant? plant;
  bool markForDelete = false;

  PlantView({super.key});

  PlantView.fromPlant(Plant p, int numPlants, {super.key}) {
    plant = p;
    if (p.data[0].commonName != null) {
      name = p.data[0].commonName!;
    }

    if (p.data[0].imageUrl != null) {
      imageUrl = p.data[0].imageUrl!;
    }
    numOfPlants = numPlants;
  }

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  String getName() {
    return widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.imageUrl,
              scale: 0.2,
              fit: BoxFit.fill
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: ColoredBox(
                color: const Color.fromARGB(115, 0, 0, 20),
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              child: IconButton(
                  icon: const Icon(Icons.delete),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => AppColor.WHITE)),
                  onPressed: () => {
                    setState(() {
                      widget.markForDelete = true;
                    })
                  }),
            ),
            Positioned(
              right: 15,
              bottom: 15,
              child: CircleAvatar(child: Text("${widget.numOfPlants}")),
            ),
          ],
        ),
      ),
    );
  }
}
