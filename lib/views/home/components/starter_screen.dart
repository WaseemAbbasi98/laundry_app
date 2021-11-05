import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/views/authenticate/signup.dart';
import 'package:laundry_app/widgets/custom_awesome_button.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class StarterScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final usertypeprovider = Provider.of<UserType>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(17, 98, 105, 0.8),
              // image: DecorationImage(
              //     image: AssetImage(
              //       'asset/images/start_bg.jpg',
              //     ),
              //     // scale: 0.5,
              //     fit: BoxFit.fill),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AwesomeButton(
                    text: 'Owner',
                    icon: Icons.dashboard,
                    cColor: Colors.greenAccent,
                    onpress: () async {
                      // bool res = await _checkInternetConnectivity(context);
                      // if (!res) {
                      //   _showDialoge('No internet...',
                      //       'Check your connection and try again', context);
                      // } else {
                      usertypeprovider.setuserType = 'owner';
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                      // }

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => SignUpPhone('worker')));
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => PhoneAuthGetPhone()));
                    }),
                SizedBox(
                  height: 30.0,
                ),
                AwesomeButton(
                    text: 'Client',
                    icon: Icons.dashboard,
                    cColor: Colors.deepOrange,
                    onpress: () async {
                      // bool res = await _checkInternetConnectivity(context);
                      // if (!res) {
                      //   _showDialoge('No internet...',
                      //       'Check your connection and try again', context);
                      // } else {
                      usertypeprovider.setuserType = 'client';

                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                      // }
                    }),
                SizedBox(
                  height: 30.0,
                ),
                // AwesomeButton(
                //     text: 'Guest',
                //     icon: Icons.dashboard,
                //     cColor: Colors.indigoAccent,
                //     onpress: () {
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => HomeDashboard()));
                //     }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    // String res;
    if (result == ConnectivityResult.none) {
      // res = 'No internet';
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('No internet... Please check your connection'),
      //   duration: Duration(seconds: 3),
      // ));
      return false;
    } else {
      // res = 'connected';
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('connected'),
      //   duration: Duration(seconds: 3),
      // ));
      return true;
    }
  }

  _showDialoge(title, text, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
