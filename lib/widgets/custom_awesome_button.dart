import 'package:flutter/material.dart';

class AwesomeButton extends StatelessWidget {
  //AwesomeButton({Key key}) : super(key: key);
  String text;
  IconData icon;
  var onpress;
  Color cColor;
  AwesomeButton(
      {this.onpress,
      required this.icon,
      required this.text,
      required this.cColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Center(
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 30.0),
              blurRadius: 30.0,
              color: Colors.black38,
            )
          ], borderRadius: BorderRadius.circular(20.0), color: Colors.white),

          //color: Colors.blueAccent,
          child: Row(
            children: [
              Container(
                  height: 50.0,
                  width: 120,
                  decoration: BoxDecoration(
                      color: cColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(200),
                        topLeft: Radius.circular(30.0),
                      )),
                  child: Center(
                    child: Text(text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  )),
              const Icon(
                Icons.dashboard,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
