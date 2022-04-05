import 'package:flutter/material.dart';
import 'package:galaxy_game/Provider/fuel_provider.dart';
import 'package:galaxy_game/Provider/quiz_provider.dart';
import 'package:galaxy_game/Screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FuelLevel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizLevel(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
