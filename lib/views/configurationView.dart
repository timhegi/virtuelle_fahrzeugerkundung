import 'package:flutter/material.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/listOfCars.dart';
import '../widgets/configuration.dart';

//Test123

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  int _selectedBottomNavIndex = 0; // For BottomNavigationBar
  int _selectedTopNavIndex = 0; // For TabBar

  static const List<Widget> _widgetOptionsBottomNav = <Widget>[
    // ListOfCars(), // Auskommentiert, da bei meinem aktuellen stand noch fehler auftreten
    Center(
      child: Text(' Home'),
    ),
    Configuration()
  ];

  static const List<Widget> _widgetOptionsTopNav = <Widget>[
    // ListOfCars(), // Auskommentiert, da bei meinem aktuellen stand noch fehler auftreten
    ListOfCars(),
    Configuration(),
    Center(
      child: Text('Configuration Tab 3'),
    ),
  ];

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  void _onTopNavigationItemTapped(int index) {
    setState(() {
      _selectedTopNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuelle Fahrzeugerkundung',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: _widgetOptionsTopNav.length,
        initialIndex: _selectedTopNavIndex,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[850],
            foregroundColor: Colors.white70,
            centerTitle: true,
            title: const Text('Virtuelle Fahrzeugerkundung'),
            bottom: _widgetOptionsBottomNav.elementAt(_selectedBottomNavIndex)
                    is Configuration
                ? TabBar(
                    dividerHeight: 0.0,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.white,
                    indicatorColor: Colors.green,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 5.0,
                    labelStyle: const TextStyle(fontSize: 13.0),
                    tabs: const [
                      Tab(text: 'Choosing car model'),
                      Tab(text: 'Car Configuration'),
                      Tab(text: 'Overview of inquiry'),
                    ],
                    onTap: _onTopNavigationItemTapped,
                  )
                : null,
          ),
          body: Center(
            child: _selectedBottomNavIndex == 0
                ? _widgetOptionsBottomNav.elementAt(_selectedBottomNavIndex)
                : _widgetOptionsTopNav.elementAt(_selectedTopNavIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tune),
                label: 'Configuration',
              ),
            ],
            currentIndex: _selectedBottomNavIndex,
            onTap: _onBottomNavigationItemTapped,
          ),
        ),
      ),
    );
  }
}
