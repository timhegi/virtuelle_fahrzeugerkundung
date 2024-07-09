import 'package:flutter/material.dart';

class GradientBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GradientBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.7),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 28),
            activeIcon: Icon(Icons.favorite, size: 30),
            label: "Favoriten",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tune_outlined, size: 28),
            activeIcon: Icon(Icons.tune, size: 30),
            label: 'Konfiguration',
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
