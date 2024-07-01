import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/car_model.dart';

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (carBox == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 400,
            child: const TextField(
              decoration: InputDecoration(
                labelText: 'Nach Modell filtern',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: carBox!.listenable(),
            builder: (context, Box<Car> box, _) {
              return ListView.builder(
                itemCount: box.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == box.length) {
                    return const SizedBox(height: 60);
                  }

                  final car = box.getAt(index);
                  if (car == null) {
                    return const SizedBox.shrink();
                  }
                  return Card(
                    margin: const EdgeInsets.all(16),
                    color: Theme.of(context).cardTheme.color,
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("Marke",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("Typ",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("Grundfarbe",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("Preis",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car.model ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(car.brand ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(car.type ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text(car.baseColor ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("${car.price} Euro",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              box.deleteAt(index);
                            },
                            icon: Icon(Icons.delete,
                                color: Theme.of(context).iconTheme.color),
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
      ],
    );
  }
}
