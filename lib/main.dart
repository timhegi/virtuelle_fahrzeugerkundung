import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtuelle_fahrzeugerkundung/views/configurationView.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CarAdapter());

  await Hive.openBox<Car>('cars');

  runApp(const MyApp());

  // Schließen der Box beim Beenden der App
  Hive.box<Car>('cars').watch().listen((event) async {
    if (!Hive.box<Car>('cars').isOpen) {
      await Hive.openBox<Car>('cars');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuelle Fahrzeugerkundung',
      home: ConfigurationView(),
    );
  }
}
