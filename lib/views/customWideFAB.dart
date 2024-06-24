import 'package:flutter/material.dart';

class CustomWideFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final String mainText;
  final String subText;
  final double price;
  final IconData icon;

  const CustomWideFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.price,
    required this.subText,
    required this.mainText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.9, // 90% der Bildschirmbreite
        height: 56.0, // Standard-FAB-Höhe
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 16.0)),
              Text(
                mainText,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${price.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        subText,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: Center(
                  child: Icon(icon, color: Colors.black, size: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
