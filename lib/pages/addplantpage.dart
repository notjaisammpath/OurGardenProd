
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/backend/plant.dart';
import 'package:flutter_walkthrough/backend/trefle.dart';
import 'package:flutter_walkthrough/pages/home.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  bool nameSubmitted = false;
  Plant? p;
  int numToAdd = 0;

  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantNumController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
  Scaffold(
    appBar: AppBar(),
    body: Column(
        children: [
          nameSubmitted
              ? FutureBuilder<Plant>(
                  future:
                      getPlant(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Plant> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      p = snapshot.data;

                      children = <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Plant found!"),
                        ),
                        Image.network(
                          snapshot.data!.data[0].imageUrl!,
                          scale: 4,
                        ),
                      ];
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        ),
                      ];
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children,
                      ),
                    );
                  },
                )
              : const Padding(
                  padding: EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      "Type the plant's name into the box below to find your plant"),
                ),
          Expanded(
            child: ColoredBox(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: plantNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a plant name'),
                      onChanged: (value) => {
                        () => nameSubmitted = false,
                      },
                      onSubmitted: (value) => {
                        setState(
                          () => nameSubmitted = true,
                        )
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      controller: plantNumController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'How many do you want to add?'),
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => {addPlant(
                        int.parse(plantNumController.text),
                      ),
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Home(startIndex: 2,)),
                    ),
                      },
                      child: const Text("done"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
  );
  void addPlant(int i){
      Back4app().addPlantToGarden(p!, i);
    
  }

   Future<Plant> getPlant() async {
    return (await Trefle()
        .getPlantList("common_name", plantNameController.text))[0];
  }
}