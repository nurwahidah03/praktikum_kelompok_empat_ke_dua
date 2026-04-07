import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:limit_kuota/main.dart';

void main() {
  testWidgets('Network page loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Cek apakah UI utama muncul
    expect(find.text('Monitoring Data'), findsOneWidget);
    expect(find.text('WiFi Today'), findsOneWidget);
    expect(find.text('Mobile Today'), findsOneWidget);
    expect(find.text('Refresh Data'), findsOneWidget);
  });
}