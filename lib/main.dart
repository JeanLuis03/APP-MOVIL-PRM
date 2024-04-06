//Jean Luis De Los Santos Garabito (2022-0442)

import 'package:flutter/material.dart';
import 'package:tarea_8/screens/my_views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jean De Los Santos | 2022-0442',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 2, 34, 59)),
        useMaterial3: true,
      ),
      home: MisVistas(),
    );
  }
}


