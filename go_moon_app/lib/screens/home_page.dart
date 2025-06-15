import 'package:flutter/material.dart';
import 'package:go_moon_app/widgets/my_custom_dropdown_button.dart';

class HomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // color: Colors.redAccent,
          height: _deviceHeight,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.05,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addTitle(),
                  _addDropDown(),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _moonImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addTitle() {
    return Text(
      "#Go Moon",
      style: TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _moonImage() {
    return Container(
      width: _deviceWidth * 0.60,
      height: _deviceHeight * 0.55,
      decoration: BoxDecoration(
        // color: Colors.redAccent,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/astro_moon.png"),
        ),
      ),
    );
  }

  Widget _addDropDown() {
    return SizedBox(
      height: _deviceHeight * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyCustomDropDownButton(
            items: [
              "Item 1",
              "Item 2",
              "Item 3",
            ],
            width: _deviceWidth,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyCustomDropDownButton(
                items: [
                  "Item 1",
                  "Item 2",
                  "Item 3",
                ],
                width: _deviceWidth * 0.4,
              ),
              MyCustomDropDownButton(
                items: [
                  "Item 1",
                  "Item 2",
                  "Item 3",
                ],
                width: _deviceWidth * 0.4,
              ),
            ],
          ),
          _addButton(),
        ],
      ),
    );
  }

  Widget _addButton() {
    return Container(
      width: _deviceWidth,
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.15,
      ),
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          "Go To Moon",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
