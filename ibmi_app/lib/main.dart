import 'package:flutter/cupertino.dart';
import 'package:ibmi_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "IBMI App",
      initialRoute: '/',
      routes: {"/": (context) => const MainScreen()},
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: "cairo"),
        ),
      ),
    );
  }
}
