import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_app/screens/ibmi_screen.dart';
import 'package:ibmi_app/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<BottomNavigationBarItem> pages = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: "Profile",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.blueAccent.shade200,
        
        middle: const Text("IBMI App", style: TextStyle(fontSize: 35)),
      ),
      child: CupertinoTabScaffold(
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                child:
                    pages[index].label == "Home"
                        ? const IbmiScreen()
                        : const ProfileScreen(),
              );
            },
          );
        },
        tabBar: CupertinoTabBar(items: pages),
      ),
    );
  }
}
