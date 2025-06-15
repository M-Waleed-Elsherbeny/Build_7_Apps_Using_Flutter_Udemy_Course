import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/http_services.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHight, _deviceWidth;
  HTTPServices? _http;

  @override
  void initState() {
    super.initState();
    _http = HTTPServices();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _customDropDownButton(),
            _getPrice(),
          ],
        ),
      ),
    );
  }

  Widget _customDropDownButton() {
    List<String> item = ['bitcoin'];
    List<DropdownMenuItem<String>>? items = item
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e.toUpperCase(),
            ),
          ),
        )
        .toList();
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(
        top: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: DropdownButton(
        items: items,
        value: item.first,
        onChanged: (value) {},
        underline: Container(),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: Colors.white,
          size: 50,
        ),
        borderRadius: BorderRadius.circular(20),
        style: TextStyle(
          color: Colors.amberAccent,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _getPrice() {
    return FutureBuilder(
      future: _http!.getUrlData("/coins/bitcoin"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(
            snapshot.data.toString(),
          );
          num price = data['market_data']['current_price']['usd'];
          num pricePercentage =
              data['market_data']['price_change_percentage_24h'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _getLogo(data['image']['large']),
              _getPriceText(price),
              _getPricePercentage(pricePercentage),
              SizedBox(
                child: _displayDescription(
                  data['description']['en'].toString(),
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.amber,
          );
        }
      },
    );
  }

  Widget _getPricePercentage(num pricePercentage) {
    return SizedBox(
      height: _deviceHight! * 0.05,
      child: Text(
        "${pricePercentage.toString()} %",
        style: TextStyle(
          color: pricePercentage < 0 ? Colors.red : Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _getPriceText(num price) {
    return Text(
      "${price.toString()} USD",
      style: TextStyle(
        color: Colors.amberAccent,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _getLogo(String image) {
    return SizedBox(
      height: _deviceHight! * 0.10,
      width: _deviceWidth! * 0.20,
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailsScreen();
              },
            ),
          );
        },
        child: Image.network(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _displayDescription(String description) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFB2A5FF),
      ),
      height: _deviceHight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListView(
        children: [
          Text(
            description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
