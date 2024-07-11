import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

import '../services/carSelectionProvider.dart';

class ListOfCars extends StatefulWidget {
  final Function onCarSelected;

  const ListOfCars({super.key, required this.onCarSelected});

  @override
  State<ListOfCars> createState() => _ListOfCarsState();
}

class _ListOfCarsState extends State<ListOfCars> {
  final images = [
    'lib/assets/images/image1.jpg',
    'lib/assets/images/image2.jpg',
    'lib/assets/images/image3.jpg',
  ];

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  final List<CarObject> carList = [
    CarObject(
        model: "G-Klasse 2019",
        brand: "Mercedes-Benz",
        type: "SUV",
        baseColor: "Schwarz",
        price: 112000),
    CarObject(
        model: "2022 Landcruiser 3",
        brand: "Toyota",
        type: "SUV",
        baseColor: "Silber Weiß",
        price: 29990),
    CarObject(
        model: "4er",
        brand: "BMW",
        type: "Benzin",
        baseColor: "Silber",
        price: 18000),
    CarObject(
        model: "4er",
        brand: "BMW",
        type: "Diesel",
        baseColor: "Silber",
        price: 18000),
    CarObject(
        model: "Golf GTI",
        brand: "Volkswagen",
        type: "Hatchback",
        baseColor: "Rot",
        price: 35000),
    CarObject(
        model: "Model S",
        brand: "Tesla",
        type: "Electric",
        baseColor: "Weiß",
        price: 80000),
    CarObject(
        model: "Civic",
        brand: "Honda",
        type: "Sedan",
        baseColor: "Blau",
        price: 22000),
  ];

  String filterModel = '';
  List<CarObject> filteredCars = [];

  @override
  void initState() {
    filteredCars = carList;

    openBox();

    super.initState();
  }

  void _selectCar(CarObject car) {
    Car selectedCar = Car(
      model: car.model,
      brand: car.brand,
      type: car.type,
      baseColor: car.baseColor,
      price: car.price,
    );
    Provider.of<CarSelectionProvider>(context, listen: false)
        .selectCar(selectedCar);
    widget.onCarSelected();
  }

  openBox() async {
    if (!Hive.isBoxOpen('cars')) {
      await Hive.openBox<Car>('cars');
    }
  }

  void filterCarsByModel(String model) {
    setState(() {
      filterModel = model.toLowerCase();
      filteredCars = carList
          .where((car) =>
              (car.model != null &&
                  car.model!.toLowerCase().contains(filterModel)) ||
              (car.brand != null &&
                  car.brand!.toLowerCase().contains(filterModel)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
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
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Nach Modell filtern',
                  border: Theme.of(context).inputDecorationTheme.border,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  contentPadding:
                      Theme.of(context).inputDecorationTheme.contentPadding,
                  suffixIcon: (myController.text != "")
                      ? Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              myController.clear();
                              setState(() {
                                filterModel = "";
                                filterCarsByModel(filterModel);
                              });
                            },
                          ),
                        )
                      : null,
                ),
                style: Theme.of(context).textTheme.labelLarge,
                onChanged: filterCarsByModel,
              ),
            ),
          ),
          if (myController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Suchergebnisse für " + myController.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          if (myController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(filteredCars.length.toString() + " Modelle gefunden"),
            ),
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView.builder(
                itemCount: filteredCars.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == filteredCars.length) {
                    return const SizedBox(height: 60);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => _selectCar(filteredCars[index]),
                        child: Card(
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  child: PageView.builder(
                                    itemCount: images.length,
                                    itemBuilder: (context, imageIndex) {
                                      return Image.asset(images[imageIndex]);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Model",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text("Marke",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text("Typ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text("Grundfarbe",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text("Preis",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .model
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .brand
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .type
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .baseColor
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(
                                          "${filteredCars.elementAt(index).price} €",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      key: ValueKey("iconButtonFavorite"),
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors
                                            .red, //Theme.of(context).iconTheme.color,
                                      ),
                                      tooltip: 'Auto zu Favoriten hinzufügen',
                                      onPressed: () {
                                        setState(() {
                                          Hive.box<Car>("cars").add(Car(
                                            model: filteredCars
                                                .elementAt(index)
                                                .model,
                                            brand: filteredCars
                                                .elementAt(index)
                                                .brand,
                                            type: filteredCars
                                                .elementAt(index)
                                                .type,
                                            baseColor: filteredCars
                                                .elementAt(index)
                                                .baseColor,
                                            price: filteredCars
                                                .elementAt(index)
                                                .price,
                                          ));
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
