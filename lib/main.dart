import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:my_website/providers/theme_provider.dart';
import 'package:my_website/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Debsoomonto Sen - Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00B4D8), // Vibrant light blue
              secondary: Color(0xFF90E0EF), // Light blue
              tertiary: Color(0xFF48CAE4), // Medium blue
              surface: Color(0xFF0A1929), // Dark blue surface
              background: Color(0xFF001B3D), // Deep dark blue background
              onPrimary: Colors.white,
              onSecondary: Color(0xFF001B3D),
              onSurface: Colors.white,
              onBackground: Colors.white,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
