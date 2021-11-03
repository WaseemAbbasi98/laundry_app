import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  var press;
  // final Color color, textColor;
  RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    // this.color = kPrimaryColor,
    // this.textColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(color: kheadingTextColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: ksubHeadingTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
              color: ksubHeadingTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}
