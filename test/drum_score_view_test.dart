import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('App shows Drum Notation title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Drum Notation'), findsOneWidget);
  });
}
