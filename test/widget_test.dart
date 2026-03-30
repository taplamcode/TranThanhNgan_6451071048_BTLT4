import 'package:btllt4/cau5/apps/upload_profile_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Show validation when file is not uploaded', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UploadProfileApp());

    final submitButton = find.widgetWithText(ElevatedButton, 'Nop Ho So');
    expect(submitButton, findsOneWidget);

    await tester.ensureVisible(submitButton);
    await tester.pumpAndSettle();

    await tester.tap(submitButton);
    await tester.pump();

    expect(find.text('Vui long upload CV cua ban!'), findsOneWidget);
  });
}
