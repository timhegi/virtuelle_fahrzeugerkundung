import 'package:flutter/material.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/modelRenderer.dart';

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

  final fuelTypes = ['Benzin', 'Diesel', 'Elektrisch', 'Hybrid'];

  final images = [
    'lib/assets/images/image1.jpg',
    'lib/assets/images/image2.jpg',
    'lib/assets/images/image3.jpg',
  ];

  @override
  void initState() {
    // Es soll standardmäßig das erste Element ausgewählt sein
    super.initState();
    selectedInteriorColor = interiorColors[0];
    selectedExteriorColor = exteriorColors[0];
    selectedBrakeColor = brakeColors[0];
    selectedFuelType = fuelTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                "Innenfarbe", interiorColors, selectedInteriorColor,
                (ColorInfo color) {
              setState(() {
                selectedInteriorColor = color;
              });
            }),
            buildColorSelector(
                "Außenfarbe", exteriorColors, selectedExteriorColor,
                (ColorInfo color) {
              setState(() {
                selectedExteriorColor = color;
              });
            }),
            buildColorSelector(
                "Bremsensattelfarbe", brakeColors, selectedBrakeColor,
                (ColorInfo color) {
              setState(() {
                selectedBrakeColor = color;
              });
            }),
            buildFuelTypeSelector(),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ModelRenderer(),
              ),
            );
          },
          child: Icon(Icons.view_in_ar,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget buildColorSelector(String title, List<ColorInfo> colorOptions,
      ColorInfo? selectedColor, Function(ColorInfo) onTap) {
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
              var color = colorOptions[index].color;
              return Padding(
                padding: const EdgeInsets.all(6.0),
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
                        color: color,
                        border: selectedColor == colorOptions[index]
                            ? Border.all(
                                color: color.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                width: 2,
                              )
                            : null,
                      ),
                      child: selectedColor == colorOptions[index]
                          ? Center(
                              child: Icon(
                                Icons.check,
                                color: color.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                size: 20,
                              ),
                            )
                          : null,
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
                padding: const EdgeInsets.all(6.0),
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
