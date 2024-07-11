import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:virtuelle_fahrzeugerkundung/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and displays home screen', (WidgetTester tester) async {
    //final Finder iconFavorite = find.byKey(ValueKey("iconButtonFavorite"));

    // Start the app
    app.main();

    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 5)); // Wait some time

    await tester.tap(find.byKey(ValueKey("iconButtonFavorite")).first);

    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 5));

    await tester.tap(find.byKey(ValueKey("fovorites")).first);

    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 5));
  });
}
