import 'package:flutter/material.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/listOfCars.dart';

class Menue extends StatefulWidget {
  const Menue({super.key});

  @override
  State<Menue> createState() => _MenueState();
}

class _MenueState extends State<Menue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "Virtuelle Fahrzeugerkundung",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          child: Text("Model auswählen",
                              style: TextStyle(color: Colors.white)),
                          decoration: BoxDecoration(color: Colors.black),
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          child: Text("Model auswählen",
                              style: TextStyle(color: Colors.white)),
                          decoration: BoxDecoration(color: Colors.black),
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Model auswählen",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(color: Colors.black),
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: ListOfCars(),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
