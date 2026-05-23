import 'package:flutter_test/flutter_test.dart';
import 'package:<%= packageName %>/app.dart';

void main() {
  testWidgets('ForgeApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ForgeApp());
    expect(find.text('<%= projectName %>'), findsWidgets);
  });
}
