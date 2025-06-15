import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter("DB");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red[200],
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[200],
          titleSpacing: 30,
          elevation: 10,
          shadowColor: Colors.red[500],
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
