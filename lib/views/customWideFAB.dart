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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 48.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 56.0,
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
              const SizedBox(width: 16.0),
              Expanded(
                flex: 2,
                child: Text(
                  mainText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${price.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        subText,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
