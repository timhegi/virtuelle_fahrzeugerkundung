import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';

class ListOfCars extends StatefulWidget {
  const ListOfCars({super.key});

  @override
  State<ListOfCars> createState() => _ListOfCarsState();
}

class _ListOfCarsState extends State<ListOfCars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black54),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 400,
              child: TextField(),
            ),
          ),
          Container(
            height: 300,
            child: ValueListenableBuilder<Box<Car>>(
              valueListenable: Hive.box<Car>('cars').listenable(),
              builder: (context, box, _) {
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final car = box.getAt(index);
                    return ListTile(
                      title: Text(car!.model ?? ""),
                      subtitle: Text(car!.brand ?? ""),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
