import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

import '../services/carImageLoader.dart';
import '../services/carSelectionProvider.dart';

class ListOfCars extends StatefulWidget {
  final Function onCarSelected;

  const ListOfCars({super.key, required this.onCarSelected});

  @override
  State<ListOfCars> createState() => _ListOfCarsState();
}

class _ListOfCarsState extends State<ListOfCars> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String filterModel = '';
  List<CarObject> filteredCars = [];

  final List<CarObject> carList = [
    CarObject(
      model: "Taycan 2020",
      brand: "Porsche",
      type: "Electric",
      baseColor: "Weiß",
      price: 103800,
      images: 'assets/images/porsche_taycan_2020',
      exteriorColors: [
        ColorInfo(color: Colors.lightBlueAccent, name: 'Skyblue'),
        ColorInfo(color: Colors.black12, name: 'Spacegrau'),
        ColorInfo(color: Colors.white, name: 'Weiß'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.green, name: 'Army Green'),
        ColorInfo(color: Colors.red, name: 'Bordeaux Red'),
        ColorInfo(color: Colors.grey, name: 'Dark Grey'),
        ColorInfo(color: Colors.pink, name: 'Darkened Pink'),
        ColorInfo(color: Colors.blue, name: 'Deep Blue'),
        ColorInfo(color: Colors.brown, name: 'Deep Taupe'),
        ColorInfo(color: Colors.green, name: 'Olive'),
        ColorInfo(color: Colors.purple, name: 'Purple'),
        ColorInfo(color: Colors.red, name: 'Rose Red'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Elektro',
      ],
    ),
    CarObject(
      model: "Camaro ZL1 2020",
      brand: "Chevrolet",
      type: "Muscle Car",
      baseColor: "Gelb",
      price: 63000,
      images: 'assets/images/chevrolet_camaro_zl1_2020',
      exteriorColors: [
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
        ColorInfo(color: Colors.grey, name: 'Grau'),
        ColorInfo(color: Colors.red, name: 'Rot'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.black, name: 'Black'),
        ColorInfo(color: Colors.blue, name: 'Blue'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: Colors.white24, name: 'Silver'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
      ],
    ),
    CarObject(
      model: "Mustang Shelby Super Snake Cabrio 2020",
      brand: "Ford",
      type: "Convertible",
      baseColor: "Schwarz",
      price: 113460,
      images: 'assets/images/ford_mustang_shelby_super_snake_cabrio_2020',
      exteriorColors: [
        ColorInfo(color: Colors.white, name: 'Grau'),
        ColorInfo(color: Colors.black, name: 'Navy'),
        ColorInfo(color: Colors.grey, name: 'Orange'),
        ColorInfo(color: Colors.blue, name: 'Schwarz'),
        ColorInfo(color: Colors.blue, name: 'Silber'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.black, name: 'Black'),
        ColorInfo(color: Colors.brown, name: 'Brown'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: Colors.white24, name: 'Silver'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
      ],
    ),
    CarObject(
      model: "G90 2023",
      brand: "Genesis",
      type: "Luxury Sedan",
      baseColor: "Taupe",
      price: 88400,
      images: 'assets/images/genesis_g90_2023',
      exteriorColors: [
        ColorInfo(color: Colors.lightBlueAccent, name: 'Blau'),
        ColorInfo(color: Colors.grey, name: 'Grau'),
        ColorInfo(color: Colors.green, name: 'Grün'),
        ColorInfo(color: Colors.pink, name: 'Pink'),
        ColorInfo(color: Colors.brown, name: 'Taupe'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.green, name: 'Dark Green'),
        ColorInfo(color: Colors.orange, name: 'Dark Orange'),
        ColorInfo(color: Colors.green, name: 'Green'),
        ColorInfo(color: Colors.grey, name: 'Grey Taupe'),
        ColorInfo(color: Colors.brown, name: 'Light Brown'),
        ColorInfo(color: Colors.blue, name: 'Midnight Blue'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: const Color(0xFF40E0D0), name: 'Turquoise'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "Range Rover SV 2023",
      brand: "Land Rover",
      type: "Luxury SUV",
      baseColor: "Rot",
      price: 218300,
      images: 'assets/images/landrover_rangerover_sv_2023',
      exteriorColors: [
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.grey, name: 'Grau'),
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.white, name: 'Weiß'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.black, name: 'Black'),
        ColorInfo(color: Colors.brown, name: 'Brown'),
        ColorInfo(color: Colors.grey, name: 'Gray'),
        ColorInfo(color: Colors.pink, name: 'Lady'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "AMG GT Coupe 2024",
      brand: "Mercedes-Benz",
      type: "Sports Car",
      baseColor: "Silber",
      price: 193600,
      images: 'assets/images/mercedes_benz_amg_gt_coupe_2024',
      exteriorColors: [
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
        ColorInfo(color: Colors.white24, name: 'Silber'),
        ColorInfo(color: Colors.grey, name: 'Stahl'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.black, name: 'Black'),
        ColorInfo(color: Colors.blue, name: 'Blue'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: Colors.white24, name: 'Silver'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "Skyline R34 GT-R 2002",
      brand: "Nissan",
      type: "Sports Car",
      baseColor: "Armygrün",
      price: 100000,
      images: 'assets/images/nissan_skyline_r34_gtr_2022',
      exteriorColors: [
        ColorInfo(color: const Color(0xFF798169), name: 'Armygrün'),
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.black26, name: 'Dunkelgrau'),
        ColorInfo(color: Colors.orange, name: 'Orange'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.lightGreen, name: 'Fade Green'),
        ColorInfo(color: Colors.redAccent, name: 'Milan Red'),
        ColorInfo(color: Colors.blueGrey, name: 'Night Blue'),
        ColorInfo(color: Colors.purple, name: 'Purple'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "Z 2023",
      brand: "Nissan",
      type: "Sports Car",
      baseColor: "Dunkelgrau",
      price: 39990,
      images: 'assets/images/nissan_z_2023',
      exteriorColors: [
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.black38, name: 'Dunkelgrau'),
        ColorInfo(color: Colors.red, name: 'Rot'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.blue, name: 'Blue'),
        ColorInfo(color: Colors.green, name: 'Green'),
        ColorInfo(color: Colors.blue, name: 'Navy Blue'),
        ColorInfo(color: Colors.green, name: 'Olive'),
        ColorInfo(color: Colors.orange, name: 'Orange'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: const Color(0xFFC2B280), name: 'Sand'),
        ColorInfo(color: const Color(0xFF4DB6AC), name: 'Spearmint'),
        ColorInfo(color: const Color(0xFF8A2BE2), name: 'Violet'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "911 Turbo S 2021",
      brand: "Porsche",
      type: "Sports Car",
      baseColor: "Blau",
      price: 207000,
      images: 'assets/images/porsche_911_turbo_s_2021',
      exteriorColors: [
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.grey, name: 'Grau'),
        ColorInfo(color: Colors.green, name: 'Grün'),
        ColorInfo(color: Colors.red, name: 'Rot'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.black, name: 'Black'),
        ColorInfo(color: Colors.blue, name: 'Blue'),
        ColorInfo(color: Colors.brown, name: 'Brown'),
        ColorInfo(color: Colors.red, name: 'Red'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
    CarObject(
      model: "GR 86 2022",
      brand: "Toyota",
      type: "Sports Car",
      baseColor: "Rot",
      price: 27900,
      images: 'assets/images/toyota_gr_86_2022',
      exteriorColors: [
        ColorInfo(color: Colors.black45, name: 'Anthrazit'),
        ColorInfo(color: Colors.blue, name: 'Blau'),
        ColorInfo(color: Colors.orange, name: 'Orange'),
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.purple, name: 'Violett'),
      ],
      interiorColors: [
        ColorInfo(color: Colors.blue, name: 'Dark Blue'),
        ColorInfo(color: Colors.green, name: 'Green'),
        ColorInfo(color: Colors.green, name: 'Light Olive'),
        ColorInfo(color: Colors.grey, name: 'Neutral Grey'),
        ColorInfo(color: Colors.orange, name: 'Orange'),
        ColorInfo(color: Colors.red, name: 'Red'),
        ColorInfo(color: Colors.red, name: 'Sports Red'),
        ColorInfo(color: const Color(0xFF40E0D0), name: 'Turquoise'),
      ],
      brakeColors: [
        ColorInfo(color: Colors.red, name: 'Rot'),
        ColorInfo(color: Colors.black, name: 'Schwarz'),
        ColorInfo(color: Colors.blueAccent, name: 'Blau'),
        ColorInfo(color: Colors.yellow, name: 'Gelb'),
      ],
      fuelTypes: [
        'Benzin',
        'Diesel',
        'Elektro',
        'Hybrid',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredCars = carList;
    openBox();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<CarSelectionProvider>(context, listen: false).resetSelections();
    // });
  }

  void _selectCar(CarObject car) {
    Provider.of<CarSelectionProvider>(context, listen: false).selectCar(car);
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

  Widget buildCarImage(CarObject car) {
    return FutureBuilder<List<String>>(
      future: CarImageLoader.getCarExteriorImages(car, car.baseColor ?? 'Weiß'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Bilder konnten nicht geladen werden'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return PageView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, imageIndex) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  snapshot.data![imageIndex],
                  fit: BoxFit.contain,
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Keine Bilder gefunden'));
        }
      },
    );
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
                            icon: const Icon(Icons.close),
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: buildCarImage(filteredCars[index]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Modell",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        filteredCars
                                            .elementAt(index)
                                            .model
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        filteredCars
                                            .elementAt(index)
                                            .brand
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        filteredCars
                                            .elementAt(index)
                                            .type
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        filteredCars
                                            .elementAt(index)
                                            .baseColor
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        "${filteredCars.elementAt(index).price} €",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable:
                                        Hive.box<Car>('cars').listenable(),
                                    builder: (context, Box<Car> box, _) {
                                      bool isFavorite = box.values.any((car) =>
                                          car.model ==
                                          filteredCars[index].model);
                                      return IconButton(
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.white,
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
                                              images: filteredCars
                                                  .elementAt(index)
                                                  .images,
                                              exteriorColors: filteredCars
                                                  .elementAt(index)
                                                  .exteriorColors,
                                              interiorColors: filteredCars
                                                  .elementAt(index)
                                                  .interiorColors,
                                              brakeColors: filteredCars
                                                  .elementAt(index)
                                                  .brakeColors,
                                              fuelTypes: filteredCars
                                                  .elementAt(index)
                                                  .fuelTypes,
                                            ));
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
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
