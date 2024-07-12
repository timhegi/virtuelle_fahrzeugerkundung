import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/modelRenderer.dart';

import '../models/car.dart';
import '../models/car_model.dart';
import '../services/carImageLoader.dart';
import '../services/carSelectionProvider.dart';

class Configuration extends StatefulWidget {
  final CarObject selectedCar;

  const Configuration({super.key, required this.selectedCar});

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  List<String> exteriorImages = [];
  List<String> interiorImages = [];
  bool showInterior = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadImages();
    });
  }

  Future<void> loadImages() async {
    final carProvider =
        Provider.of<CarSelectionProvider>(context, listen: false);
    final car = carProvider.selectedCar;
    if (car != null) {
      final exteriorColor = carProvider.selectedExteriorColor?.name;
      final interiorColor = carProvider.selectedInteriorColor?.name;

      exteriorImages = await CarImageLoader.getCarExteriorImages(
          car, exteriorColor ?? car.baseColor!);
      interiorImages = await CarImageLoader.getCarInteriorImages(
          car, interiorColor ?? car.interiorColors.first.name);
      setState(() {});
    }
  }

  void _saveFavorite() {
    final carProvider =
        Provider.of<CarSelectionProvider>(context, listen: false);
    final car = carProvider.selectedCar!;
    final Box<Car> carBox = Hive.box<Car>('cars');

    final updatedCar = Car(
      model: car.model,
      brand: car.brand,
      type: car.type,
      baseColor: carProvider.selectedExteriorColor?.name ?? car.baseColor,
      price: car.price,
      images: car.images,
      exteriorColors: car.exteriorColors,
      interiorColors: car.interiorColors,
      brakeColors: car.brakeColors,
      fuelTypes: car.fuelTypes,
      selectedExteriorColor: carProvider.selectedExteriorColor?.name,
      selectedInteriorColor: carProvider.selectedInteriorColor?.name,
      selectedBrakeColor: carProvider.selectedBrakeColor?.name,
      selectedFuelType: carProvider.selectedFuelType,
    );
    carBox.add(updatedCar);
  }

  @override
  Widget build(BuildContext context) {
    loadImages();
    return Consumer<CarSelectionProvider>(
      builder: (context, carProvider, child) {
        final car = carProvider.selectedCar;
        if (car == null) {
          return const Center(child: Text('Kein Auto ausgewählt'));
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        // Add padding to avoid buttons sticking to each other
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showInterior = !showInterior;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Text(showInterior
                              ? 'Zur Außenansicht'
                              : 'Zur Innenansicht'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        // Add padding to avoid buttons sticking to each other
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ModelRenderer(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Text('3D Modell laden'),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: showInterior
                            ? interiorImages.length
                            : exteriorImages.length,
                        itemBuilder: (context, index) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Image.asset(
                                showInterior
                                    ? interiorImages[index]
                                    : exteriorImages[index],
                                fit: BoxFit.contain,
                                width: constraints.maxWidth,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: _saveFavorite,
                        child: ValueListenableBuilder(
                          valueListenable: Hive.box<Car>('cars').listenable(),
                          builder: (context, Box<Car> box, _) {
                            bool isFavorite = box.values
                                .any((favCar) => favCar.model == car.model);
                            return Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                buildColorSelector(
                  "Innenfarbe",
                  car.interiorColors,
                  carProvider.selectedInteriorColor!,
                  (ColorInfo color) {
                    setState(() {
                      showInterior = true;
                    });
                    carProvider.selectInteriorColor(color);
                    loadImages();
                  },
                ),
                buildColorSelector(
                  "Außenfarbe",
                  car.exteriorColors,
                  carProvider.selectedExteriorColor!,
                  (ColorInfo color) {
                    setState(() {
                      showInterior = false;
                    });
                    carProvider.selectExteriorColor(color);
                    loadImages();
                  },
                ),
                buildColorSelector(
                  "Bremsensattelfarbe",
                  car.brakeColors,
                  carProvider.selectedBrakeColor!,
                  (ColorInfo color) {
                    setState(() {
                      showInterior = false;
                    });
                    carProvider.selectBrakeColor(color);
                  },
                ),
                buildFuelTypeSelector(
                    car.fuelTypes, carProvider.selectedFuelType!),
                const SizedBox(height: 120),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildColorSelector(String title, List<ColorInfo> colorOptions,
      ColorInfo selectedColor, Function(ColorInfo) onTap) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2,
            ),
            itemCount: colorOptions.length,
            itemBuilder: (context, index) {
              var colorInfo = colorOptions[index];
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(colorInfo),
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorInfo.color,
                        border: selectedColor == colorInfo
                            ? Border.all(
                                color: colorInfo.color.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          colorInfo.name,
                          style: TextStyle(
                            color: colorInfo.color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildFuelTypeSelector(
      List<String> fuelTypes, String selectedFuelType) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Antriebsart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2,
            ),
            itemCount: fuelTypes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: () {
                    Provider.of<CarSelectionProvider>(context, listen: false)
                        .selectFuelType(fuelTypes[index]);
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: selectedFuelType == fuelTypes[index]
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              fuelTypes[index],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          if (selectedFuelType == fuelTypes[index])
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
