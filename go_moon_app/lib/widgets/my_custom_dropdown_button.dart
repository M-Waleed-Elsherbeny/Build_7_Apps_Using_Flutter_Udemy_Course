import 'package:flutter/material.dart';

class MyCustomDropDownButton extends StatelessWidget {
  final List<String> items;
  final double width;

  const MyCustomDropDownButton({
    super.key,
    required this.items,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: DropdownButton(
        underline: Container(),
        onChanged: (value) {},
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),
        // value: "Select",
        borderRadius: BorderRadius.circular(15),
        hint: Text("Select"),
        dropdownColor: Colors.grey[800],
      ),
    );
  }
}
