import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';

const kBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    colors: [
      kPrimaryColor,
      kPrimaryLightColor,
    ],
  ),
);
const kContainerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(60),
    topRight: Radius.circular(60),
  ),
);
const kheadingTextStyle = TextStyle(color: Colors.black, fontSize: 18);

const kAuthTitleStyle = TextStyle(color: Colors.white, fontSize: 40);
const kAuthTextStyle =
    TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold);
const kHeadingTextStyle =
    TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
