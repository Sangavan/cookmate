import 'package:flutter/material.dart';

void main() {
  runApp(const CookMateApp());
}

class CookMateApp extends StatelessWidget {
  const CookMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'CookMate 🍳\nComing soon...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}