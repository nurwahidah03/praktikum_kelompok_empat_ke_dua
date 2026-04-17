import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:limit_kuota/src/screen/splash_screen.dart';
import 'package:limit_kuota/src/core/theme/app_theme.dart';
import 'package:limit_kuota/src/core/theme/theme_provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(),
    );
  },
);  
  }
}