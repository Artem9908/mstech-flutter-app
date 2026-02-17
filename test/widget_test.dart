import 'package:flutter_test/flutter_test.dart';
import 'package:subscription_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const SubscriptionApp());
    expect(find.byType(SubscriptionApp), findsOneWidget);
  });
}
