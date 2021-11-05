import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';

//requrired String Address, required String street, required String phone
Widget contentBox(
    {required BuildContext context,
    required String title,
    required String subtitle,
    required String amount,
    required var onTap,
    required Widget child,
    required String text}) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
            left: dialogepadding,
            top: dialogeavatarRadius + dialogepadding,
            right: dialogepadding,
            bottom: dialogepadding),
        margin: const EdgeInsets.only(top: dialogeavatarRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(dialogepadding),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    amount,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                child,
                // const SizedBox(
                //   height: 10.0,
                // ),
                // Text(
                //   phone,
                //   style: const TextStyle(
                //       color: Colors.grey,
                //       fontSize: 14.0,
                //       fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
      const Positioned(
        left: dialogepadding,
        right: dialogepadding,
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          radius: dialogeavatarRadius,
          child: Icon(
            Icons.info,
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
