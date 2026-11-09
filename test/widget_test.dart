import 'package:flutter_test/flutter_test.dart';
import 'package:filacero/main.dart';

void main() {
  testWidgets('El visitante puede entrar sin cuenta', (tester) async {
    await tester.pumpWidget(const FilaCeroApp());

    expect(find.text('Entrar sin cuenta'), findsOneWidget);
  });
}
