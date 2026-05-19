import 'package:flutter/material.dart';
import 'package:trenni/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Trenni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme.copyWith(
          surface: const Color(0xFFFFFFFF), // Cards are pure white (lighter)
        ),
        scaffoldBackgroundColor: lightColorScheme.surface, // App background is the original seed-generated surface color
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
          surface: const Color(0xFF1E1E2F), // Cards are lighter charcoal/indigo
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A), // App background is deep dark indigo
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
