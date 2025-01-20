import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment for Testline',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: const Color(0xFFD1C4E9), // Accent color
          surface: const Color(0xFFF5EAF7), // For backgrounds
          onSurface: const Color(0xFF4A004D), // Text on backgrounds
          primary: const Color(0xFF6A0DAD), // Primary color
          onPrimary: Colors.white, // Text on primary
        ),
        scaffoldBackgroundColor: const Color(0xFFF5EAF7), // Default page background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6A0DAD),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF4A004D),
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            color: Color(0xFF6A0DAD),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A0DAD),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF6A0DAD),
            side: const BorderSide(color: Color(0xFF6A0DAD), width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
