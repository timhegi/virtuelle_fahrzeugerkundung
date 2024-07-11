import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/car.dart';

class CarImageLoader {
  static Future<List<String>> getCarExteriorImages(
      CarObject car, String color) async {
    List<String> imagePaths = [];
    final String normalizedColor = normalizeColorName(color);
    final String carImagesPath =
        'lib/assets/images/${car.images?.split('/').last}/ext/$normalizedColor/';

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      imagePaths = manifestMap.keys
          .where((String key) =>
              key.toLowerCase().startsWith(carImagesPath.toLowerCase()))
          .where((String key) =>
              key.toLowerCase().endsWith('.jpg') ||
              key.toLowerCase().endsWith('.jpeg') ||
              key.toLowerCase().endsWith('.png'))
          .toList();
    } catch (e) {
      print('Error loading exterior images: $e');
    }

    return imagePaths;
  }

  static Future<List<String>> getCarInteriorImages(
      CarObject car, String color) async {
    List<String> imagePaths = [];
    final String normalizedColor = normalizeColorName(color);
    final String carImagesPath =
        'lib/assets/images/${car.images?.split('/').last}/int/';

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      imagePaths = manifestMap.keys
          .where((String key) =>
              key.toLowerCase().startsWith(carImagesPath.toLowerCase()))
          .where((String key) =>
              key.toLowerCase().contains(normalizedColor.toLowerCase()))
          .where((String key) =>
              key.toLowerCase().endsWith('.jpg') ||
              key.toLowerCase().endsWith('.jpeg') ||
              key.toLowerCase().endsWith('.png'))
          .toList();
    } catch (e) {
      print('Error loading interior images: $e');
    }

    return imagePaths;
  }

  static String normalizeColorName(String color) {
    return color
        .replaceAll('ö', 'o')
        .replaceAll('ä', 'a')
        .replaceAll(' ', '_')
        .toLowerCase();
  }

  static Future<List<String>> getAvailableExteriorColors(CarObject car) async {
    List<String> colors = [];
    final String carImagesPath =
        'lib/assets/images/${car.images?.split('/').last}/ext/';

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      colors = manifestMap.keys
          .where((String key) =>
              key.toLowerCase().startsWith(carImagesPath.toLowerCase()))
          .map((String key) {
            List<String> parts = key.split('/');
            return parts[parts.length - 2];
          })
          .toSet()
          .toList();
    } catch (e) {
      print('Error loading available exterior colors: $e');
    }

    return colors;
  }

  static Future<List<String>> getAvailableInteriorColors(CarObject car) async {
    List<String> colors = [];
    final String carImagesPath =
        'lib/assets/images/${car.images?.split('/').last}/int/';

    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      colors = manifestMap.keys
          .where((String key) =>
              key.toLowerCase().startsWith(carImagesPath.toLowerCase()))
          .map((String key) {
            String fileName = key.split('/').last;
            return fileName.split('.').first;
          })
          .toSet()
          .toList();
    } catch (e) {
      print('Error loading available interior colors: $e');
    }

    return colors;
  }
}
