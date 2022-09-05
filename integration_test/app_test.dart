import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:separate_api/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Total es 0', () {
    testWidgets('Va a la pantalla de pago y el revisa que el total sea 0',
        (tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder button = find.byKey(const Key('checkoutButton'));

      expect(button, findsOneWidget);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final Finder total = find.byKey(const Key('total'));

      expect(total, findsOneWidget);

      Text text = tester.firstWidget(total);

      expect(text.data, "0");
    });
  });

  group('Total es 400, 300 producto y 100 envio', () {
    testWidgets(
        'Agrega el primer producto,va a la pantalla de pago y el revisa que el total sea 400',
        (tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder addbutton = find.byKey(const Key('add')).first;

      await tester.ensureVisible(addbutton);

      await tester.tap(addbutton);

      await tester.pumpAndSettle();

      final Finder button = find.byKey(const Key('checkoutButton'));

      expect(button, findsOneWidget);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final Finder total = find.byKey(const Key('total'));

      expect(total, findsOneWidget);

      Text text = tester.firstWidget(total);

      expect(text.data, "400");
    });
  });
}
