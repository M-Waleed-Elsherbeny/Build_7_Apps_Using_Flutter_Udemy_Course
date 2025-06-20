import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_app/screens/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double? deviceWidth;
  @override
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: Center(
        child: InfoCard(
          deviceWidth: deviceWidth! * 0.70,
          deviceHeight: deviceWidth! * 0.70,
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final pref = snapshot.data;
                final bmiData = pref!.getStringList("bmi_data");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bmiData![0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      handelDate(bmiData[1]),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bmiData[2],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CupertinoActivityIndicator(color: Colors.blue),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String handelDate(date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate =
        "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
    return formattedDate;
  }
}
