import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cineplayy/main.dart'; // Sesuaikan nama package kamu jika berbeda

void main() {
  testWidgets('CinePlay App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CinePlayApp());

    // Verify that the login page is loaded (mencari teks 'CinePlay').
    expect(find.text('CinePlay'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}