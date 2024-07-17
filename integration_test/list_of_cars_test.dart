import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:virtuelle_fahrzeugerkundung/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and interacts with favorite button', (WidgetTester tester) async {
    // Disable debug painting before running the app
    debugPaintSizeEnabled = false;

    // Start the app
    app.main();

    // Wait for the app to settle and for the "Test starting..." text to disappear
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));  // Wait a bit longer for content to load

    // Verify that the "Test starting..." text is gone
    expect(find.text('Test starting...'), findsNothing);

    // Debug: Print out all the widgets in the tree
    debugDumpApp();

    // Define a function to find the favorite button
    Finder findFavoriteButton() => find.byKey(const ValueKey("iconButtonFavorite"));

    // Wait for the favorite button to appear (timeout after 30 seconds)
    bool buttonFound = false;
    for (int i = 0; i < 60; i++) {
      await tester.pump(const Duration(seconds: 5));
      if (findFavoriteButton().evaluate().isNotEmpty) {
        buttonFound = true;
        break;
      }
    }

    // If button not found, print debug information
    if (!buttonFound) {
      print('Favorite button not found. Widgets in the tree:');
      (find.byType(IconButton) as Iterable<Element>).forEach((element) {
        print('IconButton found: ${element.widget}');
      });
    }

    // Verify that the favorite button is found
    expect(buttonFound, isTrue, reason: 'Favorite button not found within timeout');

    // Tap the favorite button
    await tester.tap(findFavoriteButton().first);
    await tester.pumpAndSettle();

    // Find and tap the favorites tab
    final Finder favoritesTab = find.byKey(const ValueKey("favorites"));
    expect(favoritesTab, findsOneWidget, reason: 'Favorites tab not found');

    await tester.tap(favoritesTab);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));  // Wait a bit longer for content to load
  });
}