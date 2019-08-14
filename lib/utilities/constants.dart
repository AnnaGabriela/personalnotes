import 'package:flutter/material.dart';

const kMainColor = Color(0xFFED7161);
const kSecondaryColor = Color(0x20ED7160);

const kTitleTextStyle = TextStyle(
  fontSize: 38.0,
  color: Colors.blueGrey,
  height: 1.5,
);

const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Enter a value',
);

const kTitleStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

const kDescriptionStyle = TextStyle(
  fontSize: 12.0,
);
