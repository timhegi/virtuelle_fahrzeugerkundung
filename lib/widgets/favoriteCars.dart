import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car.dart';

import '../models/car_model.dart';
import '../services/carImageLoader.dart';
import '../services/carSelectionProvider.dart';
import '../views/configurationView.dart';

class FavoriteCars extends StatefulWidget {
  const FavoriteCars({Key? key}) : super(key: key);

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

  void _selectCar(Car car) {
    CarObject selectedCar = convertCarToCarObject(car);
    Provider.of<CarSelectionProvider>(context, listen: false)
        .selectCar(selectedCar);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ConfigurationView(initialTabIndex: 1),
      ),
    );
  }

  CarObject convertCarToCarObject(Car car) {
    return CarObject(
      model: car.model,
      brand: car.brand,
      type: car.type,
      baseColor: car.baseColor,
      price: car.price,
      images: car.images,
      exteriorColors: car.exteriorColors,
      interiorColors: car.interiorColors,
      brakeColors: car.brakeColors,
      fuelTypes: car.fuelTypes,
    );
  }

  Widget buildCarImage(Car car) {
    return FutureBuilder<List<String>>(
      future: CarImageLoader.getCarExteriorImages(convertCarToCarObject(car),
          car.selectedExteriorColor ?? car.baseColor ?? 'Weiß'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Fehler beim Laden der Bilder'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return PageView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, imageIndex) {
              return Image.asset(
                snapshot.data![imageIndex],
                fit: BoxFit.cover,
              );
            },
          );
        } else {
          return Center(child: Text('Keine Bilder gefunden'));
        }
      },
    );
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
              if (box.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const ConfigurationView()),
                  );
                });
                return const Center(child: CircularProgressIndicator());
              }

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
                    onTap: () => _selectCar(car),
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      color: Theme.of(context).cardTheme.color,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${car.brand} ${car.model}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text("Typ: ${car.type}"),
                                Text(
                                    "Außenfarbe: ${car.selectedExteriorColor ?? car.baseColor}"),
                                Text(
                                    "Innenfarbe: ${car.selectedInteriorColor ?? car.interiorColors.first.name}"),
                                Text(
                                    "Bremsensattelfarbe: ${car.selectedBrakeColor ?? car.brakeColors.first.name}"),
                                Text(
                                    "Kraftstoffart: ${car.selectedFuelType ?? car.fuelTypes.first}"),
                                Text("Preis: ${car.price} €"),
                                SizedBox(
                                  height: 200,
                                  child: buildCarImage(car),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                onPressed: () {
                                  box.deleteAt(index);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
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
