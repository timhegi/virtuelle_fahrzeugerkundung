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
            child: FutureBuilder(
              // As openBox method is a future
              future: Hive.openBox("cars"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If some errors occurs
                  if(snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Text("Test");
                  }
                  // openBox is future method
                  // It will take a little time
                  // it's good to return something in else condition
                } else {
                  return Scaffold();
                }
              },
            )
          ),
        ],
      ),
    );
  }
}
