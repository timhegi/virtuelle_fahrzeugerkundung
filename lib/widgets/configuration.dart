import 'package:flutter/material.dart';

class ColorInfo {
  final Color color;
  final String name;

  ColorInfo(this.color, this.name);
}

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  ColorInfo? selectedInteriorColor;
  ColorInfo? selectedExteriorColor;
  ColorInfo? selectedBrakeColor;
  String? selectedFuelType = 'Diesel';

  final interiorColors = [
    ColorInfo(Colors.white, 'White'),
    ColorInfo(Colors.black, 'Black'),
    ColorInfo(Colors.brown, 'Brown'),
  ];

  final exteriorColors = [
    ColorInfo(Colors.white, 'White'),
    ColorInfo(Colors.black, 'Black'),
    ColorInfo(Colors.red, 'Red'),
    ColorInfo(const Color(0xFF2f00ff), 'Royal Blue'),
    ColorInfo(const Color(0xFF5a5b53), 'Army Green'),
  ];

  final brakeColors = [
    ColorInfo(Colors.grey, 'Grey'),
    ColorInfo(Colors.black, 'Black'),
    ColorInfo(Colors.red, 'Red'),
    ColorInfo(Colors.blue, 'Blue'),
  ];

  final fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid'];

  final images = [
    'lib/assets/images/image1.jpg',
    'lib/assets/images/image2.jpg',
    'lib/assets/images/image3.jpg',
  ];

  @override
  void initState() {
    // Es soll standardmäßig die erste Farbe ausgewählt sein
    super.initState();
    selectedInteriorColor = interiorColors[0];
    selectedExteriorColor = exteriorColors[0];
    selectedBrakeColor = brakeColors[0];
    selectedFuelType = fuelTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.asset(images[index]);
                },
              ),
            ),
            buildColorSelector(
                "Interior Color", interiorColors, selectedInteriorColor,
                (ColorInfo color) {
              setState(() {
                selectedInteriorColor = color;
              });
            }),
            buildColorSelector(
                "Exterior Color", exteriorColors, selectedExteriorColor,
                (ColorInfo color) {
              setState(() {
                selectedExteriorColor = color;
              });
            }),
            buildColorSelector("Brake Color", brakeColors, selectedBrakeColor,
                (ColorInfo color) {
              setState(() {
                selectedBrakeColor = color;
              });
            }),
            buildFuelTypeSelector(),
          ],
        ),
      ),
    );
  }

  Widget buildColorSelector(String title, List<ColorInfo> colorOptions,
      ColorInfo? selectedColor, Function(ColorInfo) onTap) {
    return Card(
      color: Colors.grey[700],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(colorOptions[index]),
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorOptions[index].color,
                        border: selectedColor == colorOptions[index]
                            ? Border.all(
                                color: Colors.lightGreenAccent,
                                width: 2,
                              )
                            : null,
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

  Widget buildFuelTypeSelector() {
    return Card(
      color: Colors.grey[700],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Fuel Type",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
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
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedFuelType = fuelTypes[index];
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: selectedFuelType == fuelTypes[index]
                          ? Border.all(
                              color: Colors.lightGreenAccent,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        fuelTypes[index],
                        style: const TextStyle(color: Colors.white),
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
