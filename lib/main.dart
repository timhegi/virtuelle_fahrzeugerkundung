import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/services/carSelectionProvider.dart';
import 'package:virtuelle_fahrzeugerkundung/views/configurationView.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';
import 'package:virtuelle_fahrzeugerkundung/appTheme.dart';
import 'package:virtuelle_fahrzeugerkundung/models/color_info_adapter.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CarAdapter());
  Hive.registerAdapter(ColorInfoAdapter()); // Add this line

  await Hive.openBox<Car>('cars');

  runApp(
    ChangeNotifierProvider(
      create: (context) => CarSelectionProvider(),
      child: const MyApp(),
    ),
  );

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuelle Fahrzeugerkundung',
      theme: AppTheme.darkTheme,
      home: ConfigurationView(),
    );
  }
}