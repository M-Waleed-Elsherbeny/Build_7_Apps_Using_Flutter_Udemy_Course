import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_app/screens/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IbmiScreen extends StatefulWidget {
  const IbmiScreen({super.key});

  @override
  State<IbmiScreen> createState() => _IbmiScreenState();
}

class _IbmiScreenState extends State<IbmiScreen> {
  double? deviceWidth, deviceHeight;
  int ageCounter = 20, weightCounter = 100, heightCounter = 100;
  String? genderValue = "male";
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoCard(
                  deviceHeight: deviceHeight! * 0.20,
                  deviceWidth: deviceWidth! * 0.45,
                  child: cardDetails(
                    cardTitle: "Age (Year)",
                    cardCounter: ageCounter,
                    isAgeCounter: true,
                  ),
                ),
                InfoCard(
                  deviceHeight: deviceHeight! * 0.20,
                  deviceWidth: deviceWidth! * 0.45,
                  child: cardDetails(
                    cardTitle: "Weight (KG)",
                    cardCounter: weightCounter,
                    isWeightCounter: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: deviceHeight! * 0.05),
            InfoCard(
              deviceHeight: deviceHeight! * 0.15,
              deviceWidth: deviceWidth! * 0.90,
              child: cardDetails(
                cardTitle: "Height (cm)",
                cardCounter: heightCounter,
                isHeightCounter: true,
              ),
            ),
            SizedBox(height: deviceHeight! * 0.05),
            InfoCard(
              deviceHeight: deviceHeight! * 0.15,
              deviceWidth: deviceWidth! * 0.90,
              child: cardDetails(cardTitle: "Gender", isGenderSelected: true),
            ),
            SizedBox(height: deviceHeight! * 0.05),
            CupertinoButton(
              color: Colors.blueAccent.shade200,
              child: const Text(
                "Calculate IBMI",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () {
                if (weightCounter > 0 && heightCounter > 0 && ageCounter > 0) {
                  double bmi = weightCounter / math.pow(heightCounter / 100, 2);
                  calculateBMI(bmi: bmi);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI({required double bmi}) {
    String? _statues;
    if (bmi < 18.5) {
      _statues = "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      _statues = "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      _statues = "Overweight";
    } else if (bmi >= 30) {
      _statues = "Obese";
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return CupertinoAlertDialog(
          title: Text(
            _statues!,
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          content: Text(
            bmi.toStringAsFixed(2),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                saveResult(bmi, _statues);
                Navigator.pop(builderContext);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget cardDetails({
    required String cardTitle,
    int? cardCounter,
    bool isAgeCounter = false,
    bool isWeightCounter = false,
    bool isHeightCounter = false,
    bool isGenderSelected = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          cardTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          isGenderSelected
              ? genderValue! == 'male'
                  ? genderValue!.replaceFirst("m", "M")
                  : genderValue!.replaceFirst("f", "F")
              : cardCounter.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.w700,
          ),
        ),
        !isHeightCounter && !isGenderSelected
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isAgeCounter
                          ? ageCounter--
                          : isWeightCounter
                          ? weightCounter--
                          : isHeightCounter
                          ? heightCounter--
                          : 0;
                    });
                  },
                  highlightColor: Colors.redAccent.shade100,
                  icon: Icon(Icons.remove, color: Colors.red, size: 30),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isAgeCounter
                          ? ageCounter++
                          : isWeightCounter
                          ? weightCounter++
                          : 0;
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.blue, size: 30),
                ),
              ],
            )
            : isGenderSelected
            ? CupertinoSlidingSegmentedControl(
              children: {
                "male": Text(
                  "Male",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                "female": Text(
                  "Female",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              },
              onValueChanged: (value) {
                genderValue = value;
                setState(() {});
              },
              groupValue: genderValue,
              backgroundColor: Colors.blue,
            )
            : SizedBox(
              width: deviceWidth! * 0.80,
              child: CupertinoSlider(
                min: 0,
                max: 250,
                // divisions: 100,
                value: heightCounter.toDouble(),
                onChanged: (value) {
                  heightCounter = value.toInt();
                  setState(() {});
                },
              ),
            ),
      ],
    );
  }

  void saveResult(double bmi, String? statues) async {
    String bmiDate = DateTime.now().toString();
    var pref = await SharedPreferences.getInstance();
    await pref.setStringList("bmi_data", <String>[
      statues!,
      bmiDate,
      bmi.toStringAsFixed(2),
    ]);
    log("Saved Successfully");
  }
}
