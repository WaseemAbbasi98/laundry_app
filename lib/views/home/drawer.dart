// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/views/authenticate/sign_in.dart';
import 'package:laundry_app/views/corders/order_home.dart';
import 'package:laundry_app/views/home/components/starter_screen.dart';
import 'package:laundry_app/views/profile/profile.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class MainDrawer extends StatefulWidget {
  // final String showscreen;
  // MainDrawer({this.showscreen});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // var document = FirebaseFirestore.instance
  //     .collection('clients')
  //     .doc(_auth.currentUser.uid);

  // String userName =  document[''];
  String? username = ' user name';
  String? useremail = 'user email';
  String uid = '';
  @override
  void initState() {
    // print('show screen is');
    // print(widget.showscreen);
    uid = _auth.currentUser!.uid;
    useremail = _auth.currentUser!.email!;
    if (_auth.currentUser!.displayName != null) {
      username = _auth.currentUser!.displayName;
    }

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final stateprovider =
    // Provider.of<AppStateController>(context, listen: false);
    String uimage = 'asset/images/user.png';
    Color dcolor = Colors.grey;
    bool show = true;
    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              // color: Colors.orange[700],
              color: kPrimaryColor,

              child: Column(
                // mainAxisAlignment: .s,
                children: [
                  // stateprovider.viewState == ViewState.Busy
                  // ? CircularProgressIndicator(
                  //     backgroundColor: Colors.deepOrange,
                  //     semanticsLabel: "Loading Data",
                  //   )
                  // :
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(uimage), fit: BoxFit.cover)),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    username.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0.0),
            _containerWidget(),
            // SizedBox(
            //   height: 5.0,
            // ),

            _containersecondWidget(),
            // SizedBox(
            //   height: 10.0,
            // ),

            if (show) ...[
              Container(
                color: Colors.white,
                child: _listtiles(
                    text: 'LogOut',
                    icon: Icons.logout,
                    onClick: () {
                      _auth.signOut();
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StarterScreen()));
                    }),
              ),
            ] else ...[
              Text('Login'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _containerWidget() {
    final usertypeprovider = Provider.of<UserType>(context, listen: false);

    Color dcolor = Colors.grey;
    // final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5.0),
      //padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      child: Column(
        children: [
          _listtiles(
              text: 'Profile',
              icon: Icons.person,
              onClick: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              uid: uid,
                              showtop: false,
                            )));
              }),
          usertypeprovider.usertype == 'client'
              ? Divider(
                  color: dcolor,
                  indent: 20.0,
                )
              : SizedBox(
                  height: 2.0,
                ),
          // widget.showscreen == 'client'
          //     ?
          //  _listtiles(
          //     text: 'My Orders',
          //     icon: Icons.add_box,
          //     onClick: () {
          //       // Navigator.pop(context);
          //       // Navigator.push(
          //       //     context,
          //       //     //  MaterialPageRoute(builder: (context) => SignIn()));

          //       //     MaterialPageRoute(builder: (context) => Orderstate()));
          //     }),
          // // :
          usertypeprovider.usertype == 'client'
              ? _listtiles(
                  text: 'My Orders',
                  icon: Icons.add_box,
                  onClick: () {
                    // orderprovider.chageorderto = _auth.currentUser.uid;
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        //  MaterialPageRoute(builder: (context) => SignIn()));

                        MaterialPageRoute(builder: (context) => JobOrders()));
                  })
              : SizedBox(
                  height: 2.0,
                ),
          usertypeprovider.usertype == 'client'
              ? Divider(
                  color: dcolor,
                  indent: 20.0,
                )
              : SizedBox(
                  height: 2.0,
                ),
          _listtiles(
              text: 'Notifications',
              icon: Icons.notifications,
              onClick: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => NotificationPage()));
                // Navigator.pop(context);
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => ALogin()));
              }),
          // Divider(
          //   color: dcolor,
          //   indent: 20.0,
          //   endIndent: 20.0,
          // ),
        ],
      ),
    );
  }

  Widget _containersecondWidget() {
    Color dcolor = Colors.grey;
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 5.0),
      //padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.white,
      child: Column(
        children: [
          // _listtiles(
          //     text: 'Register',
          //     icon: FontAwesomeIcons.userLock,
          //     onClick: () {
          //       Navigator.pop(context);
          //       Navigator.push(
          //           context,
          //           //  MaterialPageRoute(builder: (context) => SignIn()));

          //           MaterialPageRoute(builder: (context) => Authenticate()));
          //     }),
          // Divider(
          //   color: dcolor,
          //   indent: 20.0,
          //   //endIndent: 20.0,
          // ),
          // _listtiles(
          //     text: 'Verification',
          //     icon: Icons.verified_user_sharp,
          //     onClick: () {
          //       Navigator.pop(context);
          //       Navigator.push(
          //           context,
          //           //  MaterialPageRoute(builder: (context) => SignIn()));

          //           MaterialPageRoute(
          //               builder: (context) => IdVerification(
          //                     uid: uid,
          //                   )));
          //     }),

          // Divider(
          //   color: dcolor,
          //   indent: 20.0,
          //   //endIndent: 20.0,
          // ),
          // widget.showscreen == 'worker'
          //     ? _listtiles(
          //         text: 'MY Groups',
          //         icon: Icons.group,
          //         onClick: () {
          //           Navigator.pop(context);
          //           Navigator.push(
          //               // context, MaterialPageRoute(builder: (context) => SignUp()));

          //               context,
          //               // MaterialPageRoute(builder: (context) => MyGroups()));
          //               MaterialPageRoute(builder: (context) => HomePage()));
          //         })
          //     : SizedBox(
          //         height: 0.0,
          //       ),
          // widget.showscreen == 'worker'
          //     ? Divider(
          //         color: dcolor,
          //         indent: 20.0,
          //         endIndent: 20.0,
          //       )
          //     : SizedBox(),
        ],
      ),
    );
  }

  Widget _listtiles(
      {required String text, required IconData icon, var onClick}) {
    double iSize = 20.0;
    //Color iColor = Colors.orange;
    Color iColor = kPrimaryColor;
    Color fcolor = Colors.white;
    return ListTile(
      leading: FaIcon(
        icon,
        size: iSize,
        color: iColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 18,
        ),
      ),
      onTap: onClick,
    );
  }
}
