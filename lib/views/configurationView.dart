import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:virtuelle_fahrzeugerkundung/appTheme.dart';
import 'package:virtuelle_fahrzeugerkundung/models/car_model.dart';
import 'package:virtuelle_fahrzeugerkundung/services/carSelectionProvider.dart';
import 'package:virtuelle_fahrzeugerkundung/views/customWideFAB.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/favoriteCars.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/listOfCars.dart';
import 'package:virtuelle_fahrzeugerkundung/widgets/summary.dart';

import '../widgets/configuration.dart';
import 'GradientBottomNavBar.dart';

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

  void _onCarSelected() {
    setState(() {
      _firstTabReady = true;
      _tabController.animateTo(1);
    });
  }

  static const List<Widget> _widgetOptionsBottomNav = <Widget>[
    FavoriteCars(),
    Configuration()
  ];

  @override
  void initState() {
    super.initState();
    if(Hive.box<Car>("cars").isEmpty) _selectedBottomNavIndex = 1;
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
      if(Hive.box<Car>("cars").isEmpty) _selectedBottomNavIndex = 1;
      else _selectedBottomNavIndex = index;
    });
  }

  void _onFabPressed() {
    if (_selectedTopNavIndex == 1) {
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
          fontSize: 14.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtuelle Fahrzeugerkundung',
      theme: AppTheme.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: (_selectedBottomNavIndex == 0) ? Text("Meine Autos") : Text("Bestellung"),
          bottom: _selectedBottomNavIndex == 1
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
                        opacity: _firstTabReady ? 1.0 : 0.3,
                        child: const Text('Anpassen'),
                      ),
                    ),
                    Tab(
                      child: Opacity(
                        opacity: _secondTabReady ? 1.0 : 0.3,
                        child: const Text('Abschluss'),
                      ),
                    ),
                  ],
                )
              : null,
        ),
        body: Stack(
          children: [
            Center(
              child: _selectedBottomNavIndex == 0
                  ? _widgetOptionsBottomNav.elementAt(_selectedBottomNavIndex)
                  : IndexedStack(
                      index: _selectedTopNavIndex,
                      children: [
                        ListOfCars(onCarSelected: _onCarSelected),
                        const Configuration(),
                        const Center(
                          child: Summary(),
                        ),
                      ],
                    ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GradientBottomNavBar(
                currentIndex: _selectedBottomNavIndex,
                onTap: _onBottomNavigationItemTapped,
              ),
            ),
          ],
        ),
        floatingActionButton: _selectedBottomNavIndex == 1
            ? Consumer<CarSelectionProvider>(
                builder: (context, carProvider, child) {
                  final selectedCar = carProvider.selectedCar;
                  if (_selectedTopNavIndex != 0) {
                    return CustomWideFAB(
                      onPressed: _onFabPressed,
                      mainText: '${selectedCar?.brand!} ${selectedCar?.model!}',
                      subText: 'All prices incl.',
                      price: selectedCar?.price ?? 0.0,
                      icon: _getFABIcon(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  IconData _getFABIcon() {
    switch (_selectedTopNavIndex) {
      // Hier kann man die icons für die aktuelle ansicht anpassen, sofern nötig
      case 1:
        return Icons.arrow_forward;
      case 2:
        return Icons.send;
      default:
        return Icons.arrow_forward;
    }
  }
}
