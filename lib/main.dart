import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';
import 'package:virtuelle_fahrzeugerkundung/views/menue.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Check if the box "cars" is already open
  if (!Hive.isBoxOpen('cars')) {
    // Register the adapter
    Hive.registerAdapter(CarAdapter());
    await Hive.openBox<Car>('cars');
  }




  // Create some cars
  var vwPolo = Car(model: "VW Polo", brand: "VW", type: "SUV", baseColor: "Gelb", price: 13000.00);
  var nissanMicra = Car(model: "Nissan Micra", brand: "Nissan", type: "SUV", baseColor: "Gelb", price: 13000.00);
  var bmw4er = Car(model: "BMW 4er", brand: "BMW", type: "SUV", baseColor: "Gelb", price: 13000.00);
  var vwPolo2 = Car(model: "VW Polo", brand: "VW", type: "SUV", baseColor: "Gelb", price: 13000.00);
  var vwPolo3 = Car(model: "VW Polo", brand: "VW", type: "SUV", baseColor: "Gelb", price: 13000.00);

  // Add cars to the box
  Hive.box<Car>("cars").addAll([vwPolo, nissanMicra, bmw4er, vwPolo2, vwPolo3]);

  // Run the app
  runApp(const MyApp());

  if(Hive.box<Car>("cars").isOpen) {
    Hive.box<Car>("cars").close();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Titel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Menue();
  }
}
