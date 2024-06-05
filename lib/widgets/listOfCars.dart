import 'package:flutter/material.dart';


class ListOfCars extends StatefulWidget {
  const ListOfCars({ super.key });

  @override
  State<ListOfCars> createState() => _ListOfCarsState();
}

class _ListOfCarsState extends State<ListOfCars> {


  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: Colors.black54),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),

            width: 400,
          child: TextField(),
                ),
        ),
          Container(
            height: 300,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const Icon(Icons.list),
                      trailing: const Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("List item $index"));
                }),
          ),
        ],
      ),
    );
  }
}