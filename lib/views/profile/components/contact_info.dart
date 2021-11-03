import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';

class ContactInfo extends StatefulWidget {
  final String email;
  final String mobileno;
  ContactInfo({required this.email, required this.mobileno});

  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.green,
        //padding: EdgeInsets.only(left: 20.0),
        width: MediaQuery.of(context).size.width,
        //height: 150.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowWidget(
                      heading: 'EMAIL',
                      subheading: widget.email,
                      icon: Icons.email),
                  SizedBox(
                    height: 20.0,
                  ),
                  _rowWidget(
                      heading: 'MOBILE',
                      subheading: widget.mobileno,
                      icon: Icons.phone),
                ],
              ),
            ),
          ],
        )
        // color: Colors.amber,

        );
  }

  Widget _rowWidget(
      {required String heading,
      required String subheading,
      required IconData icon}) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          icon,
          color: kPrimaryColor,
          size: 30,
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subheading,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Quicksand',
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
