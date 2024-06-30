import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
        type: "Diesel",
        baseColor: "Silber",
        price: 18000),
    CarObject(
        model: "4er",
        brand: "BMW",
        type: "Diesel",
        baseColor: "Silber",
        price: 18000),
    CarObject(
        model: "4er",
        brand: "BMW",
        type: "Diesel",
        baseColor: "Silber",
        price: 18000),
  ];

  String filterModel = '';
  List<CarObject> filteredCars = [];

  @override
  void initState() {
    // Initialize the filtered list with all products
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
    print(
        'Car selected in ListOfCars: ${selectedCar.model} - ${selectedCar.brand}');
    widget.onCarSelected();
  }

  openBox() async {
    if (!Hive.isBoxOpen('cars')) {
      await Hive.openBox<Car>('cars');
    }
  }

  // Function to filter products by model
  void filterCarsByModel(String model) {
    setState(() {
      filterModel = model;
      // Use the 'where' method to filter products by model
      filteredCars = carList
          .where((car) => car.model != null && car.model!.contains(filterModel))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: filterCarsByModel,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[850],
              child: ListView.builder(
                itemCount: filteredCars.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == filteredCars.length) {
                    // Return SizedBox for the last item
                    return const SizedBox(height: 60);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => _selectCar(filteredCars[index]),
                        child: Card(
                          color: HexColor("3D3D3D"),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  // Set a fixed width for the images
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .model
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .brand
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .type
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left),
                                      Text(
                                          filteredCars
                                              .elementAt(index)
                                              .baseColor
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left),
                                      Text(
                                          filteredCars
                                                  .elementAt(index)
                                                  .price
                                                  .toString() +
                                              " Euro",
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
                                      icon: const Icon(Icons.favorite,
                                          color: Colors.red),
                                      tooltip: 'Auto zu Favoriten hinzufügen',
                                      onPressed: () =>
                                          Hive.box<Car>("cars").add(selectedCar);
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
