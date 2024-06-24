import 'package:flutter/material.dart';
import 'package:virtuelle_fahrzeugerkundung/views/customWideFAB.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/listOfCars.dart';
import '../widgets/configuration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView>
    with SingleTickerProviderStateMixin {
  int _selectedBottomNavIndex = 0;
  int _selectedTopNavIndex = 0;
  bool _firstTabReady = false;
  bool _secondTabReady = false;
  late TabController _tabController;

  static const List<Widget> _widgetOptionsBottomNav = <Widget>[
    Center(
      child: Text(' Home'),
    ),
    Configuration()
  ];

  static const List<Widget> _widgetOptionsTopNav = <Widget>[
    ListOfCars(),
    Configuration(),
    Center(
      child: Text('Configuration Tab 3'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 0 ||
          (_tabController.index == 1 && _firstTabReady) ||
          (_tabController.index == 2 && _secondTabReady)) {
        setState(() {
          _selectedTopNavIndex = _tabController.index;
        });
      } else {
        _tabController.index = _selectedTopNavIndex;
      }
    }
  }

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  void _onFabPressed() {
    if (_selectedTopNavIndex == 0) {
      setState(() {
        _firstTabReady = true;
        _tabController.animateTo(1);
      });
    } else if (_selectedTopNavIndex == 1) {
      setState(() {
        _secondTabReady = true;
        _tabController.animateTo(2);
      });
    } else if (_selectedTopNavIndex == 2) {
      Fluttertoast.showToast(
          msg: "Anfrage abgeschickt",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuelle Fahrzeugerkundung',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white70,
          centerTitle: true,
          title: const Text('Virtuelle Fahrzeugerkundung'),
          bottom: _widgetOptionsBottomNav.elementAt(_selectedBottomNavIndex)
                  is Configuration
              ? TabBar(
                  controller: _tabController,
                  dividerHeight: 0.0,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 5.0,
                  tabs: [
                    const Tab(text: 'Auswahl'),
                    Tab(
                      child: Opacity(
                        opacity: _firstTabReady ? 1.0 : 0.5,
                        child: const Text('Anpassen'),
                      ),
                    ),
                    Tab(
                      child: Opacity(
                        opacity: _secondTabReady ? 1.0 : 0.5,
                        child: const Text('Abschluss'),
                      ),
                    ),
                  ],
                )
              : null,
        ),
        body: Center(
          child: _selectedBottomNavIndex == 0
              ? _widgetOptionsBottomNav.elementAt(_selectedBottomNavIndex)
              : IndexedStack(
                  index: _selectedTopNavIndex,
                  children: _widgetOptionsTopNav,
                ),
        ),
        floatingActionButton: _selectedBottomNavIndex == 1
            ? CustomWideFAB(
                onPressed: _onFabPressed,
                mainText: _getFABMainText(),
                subText: 'All prices incl.',
                price: _getFABPrice(),
                icon: _getFABIcon(),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    );
  }

  String _getFABMainText() {
    return 'G-Klasse';
    // Hier soll irgendwann das car.model zurückgegeben werden
  }

  double _getFABPrice() {
    return 112000.0;
    // Hier soll irgendwann das car.price zurückgegeben werden
  }

  IconData _getFABIcon() {
    switch (_selectedTopNavIndex) { // Hier kann man die icons für die aktuelle ansicht anpassen, sofern nötig
      case 0:
        return Icons.directions_car;
      case 1:
        return Icons.build;
      case 2:
        return Icons.send;
      default:
        return Icons.arrow_forward;
    }
  }
}
