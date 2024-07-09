import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car.dart';
import '../models/car_model.dart';
import '../services/carSelectionProvider.dart';

class FavoriteCars extends StatefulWidget {
  const FavoriteCars({super.key});

  @override
  State<FavoriteCars> createState() => _FavoriteCarsState();
}

class _FavoriteCarsState extends State<FavoriteCars> {
  Box<Car>? carBox;

  final images = [
    'lib/assets/images/image1.jpg',
    'lib/assets/images/image2.jpg',
    'lib/assets/images/image3.jpg',
  ];

  /*void _selectCar(CarObject car) {
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
  }*/

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
                  return GestureDetector(
                    //onTap: () => _selectCar(filteredCars[index]),  // Hier müsste noch mal
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      color: Theme.of(context).cardTheme.color,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text("Auto " + index.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Text(car.model.toString()),
                                    Text("Standard")
                                  ],
                                ),
                                IconButton( icon: Icon(Icons.delete), onPressed: () {
                                  Hive.box<Car>("cars").deleteAt(index);
                                },)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: PageView.builder(
                                  itemCount: images.length,
                                  itemBuilder: (context, imageIndex) {
                                    return Image.asset(images[imageIndex]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
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
