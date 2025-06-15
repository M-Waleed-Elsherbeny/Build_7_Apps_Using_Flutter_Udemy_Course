import 'package:flutter/material.dart';
import './screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO MOON APP',
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Color.fromARGB(255, 31, 31, 31),
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
