import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import '../models/car_model.dart';
import '../services/carImageLoader.dart';
import '../services/carSelectionProvider.dart';

class Summary extends StatefulWidget {
  final Function(bool) onSubmit;

  const Summary({super.key, required this.onSubmit});

  @override
  State<Summary> createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  final _formKey = GlobalKey<FormState>();

  bool validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(true);
      return true;
    }
    widget.onSubmit(false);
    return false;
  }

  String? selectedValueAnrede;
  final List<String> itemsAnrede = ["Herr", "Frau"];
  String? selectedValueTitel;
  final List<String> itemsTitel = ["Doktor", "Professor"];

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  Color emailBorderColor = Colors.grey.shade300;

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
          return const Center(child: Text('Keine Bilder gefunden'));
        }
      },
    );
  }

  Widget buildCarCard(Car car) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Theme.of(context).cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${car.brand} ${car.model}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("Typ: ${car.type}"),
            Text("Außenfarbe: ${car.selectedExteriorColor ?? car.baseColor}"),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carSelectionProvider = Provider.of<CarSelectionProvider>(context);
    final selectedCar = carSelectionProvider.selectedCar;

    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Zusammenfassung",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  if (selectedCar != null)
                    buildCarCard(Car(
                      model: selectedCar.model,
                      brand: selectedCar.brand,
                      type: selectedCar.type,
                      baseColor: selectedCar.baseColor,
                      price: selectedCar.price,
                      images: selectedCar.images,
                      exteriorColors: selectedCar.exteriorColors,
                      interiorColors: selectedCar.interiorColors,
                      brakeColors: selectedCar.brakeColors,
                      fuelTypes: selectedCar.fuelTypes,
                      selectedExteriorColor:
                          carSelectionProvider.selectedExteriorColor?.name,
                      selectedInteriorColor:
                          carSelectionProvider.selectedInteriorColor?.name,
                      selectedBrakeColor:
                          carSelectionProvider.selectedBrakeColor?.name,
                      selectedFuelType: carSelectionProvider.selectedFuelType,
                    )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Anrede",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        hint: const Text(
                          "Wählen Sie eine Anrede",
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        value: selectedValueAnrede,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueAnrede = newValue;
                          });
                        },
                        items: itemsAnrede
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: const SizedBox.shrink(),
                        // Entfernt den Unterstrich
                        isExpanded:
                            true, // Optional, um sicherzustellen, dass das Dropdown-Menü den gesamten Container füllt
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Titel",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        hint: const Text(
                          "Wählen Sie eine Titel",
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        value: selectedValueTitel,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValueTitel = newValue;
                          });
                        },
                        items: itemsTitel
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: const SizedBox.shrink(),
                        // Entfernt den Unterstrich
                        isExpanded: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Vorname*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte einen Vornamen eingeben";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nachname*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte einen Nachnamen eingeben";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "E-Mail*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            if (validateEmail(value) == null) {
                              emailBorderColor = const Color(0xFFE91e63);
                            } else {
                              emailBorderColor = Colors.grey.shade300;
                            }
                          });
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Telefonnummer*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte eine Telefonnummer eingeben";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Unternehmen",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Anschrift*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte eine Anschrift eingeben";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
