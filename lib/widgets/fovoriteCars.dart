import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

class FavoriteCars extends StatefulWidget {
  const FavoriteCars({super.key});

  @override
  State<FavoriteCars> createState() => _FavoriteCarsState();
}

class _FavoriteCarsState extends State<FavoriteCars> {
  Box<Car>? carBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  openBox() async {
    if (!Hive.isBoxOpen('cars')) {
      carBox = await Hive.openBox<Car>('cars');
    } else {
      carBox = Hive.box<Car>('cars');
    }
    setState(
        () {}); // Aktualisiere den Zustand, damit das Widget neu gerendert wird, sobald die Box geöffnet ist
  }

  @override
  Widget build(BuildContext context) {
    if (carBox == null) {
      // Zeige einen Ladeindikator, solange die Box noch geöffnet wird
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: BoxDecoration(color: Colors.grey[850]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Filter by Model',
                  border: InputBorder.none,
                ),
                //onChanged: filterCarsByModel,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[850],
              child: StreamBuilder(
                stream: carBox!.watch(),
                builder:
                    (BuildContext context, AsyncSnapshot<BoxEvent> snapshot) {
                  return ListView.builder(
                    itemCount: carBox!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final car = carBox!.getAt(index) as Car;
                      return Card(
                        margin: EdgeInsets.all(16),
                        color: HexColor("3D3D3D"),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Model",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text("Marke",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text("Typ",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text("Grundfarbe",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text("Preis",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(car.model!,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text(car.brand!,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text(car.type!,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text(car.baseColor!,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                    Text("${car.price} Euro",
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          carBox!.deleteAt(index);
                                        });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
