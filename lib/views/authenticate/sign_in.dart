import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/constants/style.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/owner_module/dashboard.dart';
import 'package:laundry_app/services/authservice.dart';
import 'package:laundry_app/views/authenticate/signup.dart';
import 'package:laundry_app/views/home/dashboard.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_dialogebox.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final String email;
  SignIn({required this.email});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cellnumberController = TextEditingController();
  final TextEditingController skillcotroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordcotroller = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
  bool _isObscure = true;

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';
  bool showtimer = false;
  final _formkey = GlobalKey<FormState>();
  final authservice = AuthService();
  String error2 = '';
  String phonenumber = '';
  String skill = '';
  String name = '';
  String email = '';
  String address = '';
  String password = '';
  bool isSpin = false;
  bool isworker = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    skillcotroller.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordcotroller.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return registerScreen();
  }

  Widget registerScreen() {
    final usertypeprovider = Provider.of<UserType>(context, listen: false);

    final node = FocusScope.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: kBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "LogIn",
                        style: kAuthTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcom Back",
                        style: kAuthTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        // color: kPrimaryColor,
                        onPressed: () {
                          print('login tap');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: kAuthTitleStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Don't have account",
                        style: kAuthTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: kContainerBoxDecoration,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 80,
                        ),
                        Form(
                          //  autovalidateMode: ,
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  // initialValue:
                                  //     widget.email != '' ? widget.email : '',
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter your email',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: 'Email'),
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      email = val;
                                    });
                                    // print('validation check..');
                                    // print(validateEmail(val));
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter  email address';
                                    }
                                    // print(validateEmail(value));
                                    if (validateEmail(value) == false) {
                                      return 'Please enter valid email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  controller: passwordcotroller,
                                  obscureText: _isObscure,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      suffixIcon: IconButton(
                                        color: kPrimaryColor,
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: 'Password'),
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter  password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Center(
                                child: ButtonWidget(
                                  btnText: "Login",
                                  onClick: () async {
                                    //
                                    try {
                                      if (_formkey.currentState!.validate()) {
                                        final result =
                                            await authservice.signInWithEmail(
                                                email: email,
                                                password: password);
                                        print('boolean value is...');
                                        print(iserror);
                                        if (iserror) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            dialogepadding),
                                                  ),
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: contentBox(
                                                      child: SizedBox(
                                                        height: 2,
                                                      ),
                                                      context: context,
                                                      title: 'LogIn Error',
                                                      subtitle: error,
                                                      amount: '',
                                                      onTap: () {
                                                        setState(() {
                                                          iserror = false;
                                                          error = '';
                                                        });
                                                      },
                                                      text: 'Try Again'),
                                                );
                                              });
                                          // _scaffoldKey.currentState!
                                          //     .showSnackBar(SnackBar(
                                          //   content: Text(error),
                                          //   duration: Duration(seconds: 3),
                                          // ));
                                        }
                                        if (result != null) {
                                          usertypeprovider.usertype == 'client'
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeDashboard(
                                                            useremail: '',
                                                          )),
                                                )
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OwnerDashboard(
                                                            showScreen: '',
                                                          )));
                                        }
                                      } else {
                                        print('validation failed...');
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // void createSnackBar(String message) {
  // final snackBar = new SnackBar(content: new Text(message),
  // backgroundColor: Colors.red);

  // // Find the Scaffold in the Widget tree and use it to show a SnackBar!
  // Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  // }

//   List<Widget> createRadioListSkill() {
//     List<Widget> widgets = [];
//     for (Skills sk in skilllist) {
//       widgets.add(
//         RadioListTile(
//           value: sk,
//           groupValue: seletedskill,
//           title: Text(sk.title),
//           onChanged: (currentskill) {
//             setSelectedSkill(currentskill);
//           },
//           selected: seletedskill == sk,
//           activeColor: Colors.deepOrange,
//         ),
//       );
//     }
//     return widgets;
//   }

//   Widget returnOTPScreen() {
//     final wprovider = Provider.of<WorkerProvider>(context, listen: false);
//     // final cprovider = Provider.of<ClientProvider>(context, listen: false);
//     final uprovider = Provider.of<UserProvider>(context, listen: false);
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: new AppBar(
//           title: Text('Hunarmand'),
//           centerTitle: true,
//           backgroundColor: Colors.deepOrange,
//         ),
//         body: ListView(children: [
//           Center(
//             child: Form(
//               key: _formKeyOTP,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 10.0),
//                           child: Text(
//                               !isLoading
//                                   ? "Enter OTP from SMS"
//                                   : "Sending OTP code SMS",
//                               textAlign: TextAlign.center))),
//                   !isLoading
//                       ? Container(
//                           child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 10.0),
//                           child: TextFormField(
//                             enabled: !isLoading,
//                             controller: otpController,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: <TextInputFormatter>[
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             initialValue: null,
//                             autofocus: true,
//                             decoration: InputDecoration(
//                                 labelText: 'OTP',
//                                 labelStyle: TextStyle(color: Colors.black)),
//                             validator: (value) {
//                               if (value.isEmpty) {
//                                 return 'Please enter OTP';
//                               } else
//                                 return null;
//                             },
//                           ),
//                         ))
//                       : Container(),
//                   !isLoading
//                       ? Column(
//                           children: [
//                             FadeAnimation(
//                               1.6,
//                               Center(
//                                 child: ButtonWidget(
//                                   btnText: "Submit",
//                                   onClick: () async {
//                                     if (_formKeyOTP.currentState.validate()) {
//                                       setState(() {
//                                         isResend = false;
//                                         isLoading = true;
//                                       });
//                                       try {
//                                         uprovider.changephoneno = phonenumber;
//                                         uprovider.changedpassword = password;
//                                         uprovider.changeaddress = address;
//                                         uprovider.changename = name;
//                                         uprovider.changeemail = email;
//                                         isworker
//                                             ? wprovider.changeskill = skill
//                                             : null;

//                                         final result =
//                                             authservice.signInWithPhoneNumber(
//                                                 smscode: otpController.text,
//                                                 name: nameController.text,
//                                                 type: widget._showScreen,
//                                                 skill: skill,
//                                                 phone: phonenumber,
//                                                 city: address,
//                                                 email: email,
//                                                 password: password);
// // result.then((value) async {
// //                     if (value.user != null) {

// //                     });
//                                         // print('result at screen');
//                                         // print(
//                                         //     result.then((value) => value.uid));

//                                         if (result != null && kisotpmatch) {
//                                           if (widget._showScreen == 'worker') {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       WorkerDashboard(
//                                                         showScreen:
//                                                             widget._showScreen,
//                                                       )),
//                                             );
//                                           } else if (widget._showScreen ==
//                                               'client') {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       HomeDashboard()),
//                                             );
//                                           }
//                                         } else {
//                                           isLoading = false;
//                                           // isResend = true;
//                                           _scaffoldKey.currentState
//                                               .showSnackBar(SnackBar(
//                                                   content:
//                                                       Text('OTP not match')));
//                                           // setState(() {
//                                           //   // showtimer = true;
//                                           // });
//                                         }
//                                       } catch (e) {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                       }
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20.0,
//                             ),
//                             showtimer
//                                 ? Column(
//                                     children: [
//                                       Text(
//                                         'Resending code in.',
//                                         style: TextStyle(
//                                           color: Colors.blueGrey,
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       // SizedBox(
//                                       //   height: 10.0,
//                                       // ),
//                                       CircularCountDownTimer(
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 4,
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 4,
//                                         duration: 60,
//                                         fillColor: Colors.deepOrange,
//                                         color: Colors.white,
//                                         controller: _controller,
//                                         backgroundColor: Colors.white54,
//                                         strokeWidth: 10.0,
//                                         strokeCap: StrokeCap.round,
//                                         isTimerTextShown: true,
//                                         isReverse: false,
//                                         onComplete: () {
//                                           setState(() {
//                                             isResend = true;
//                                             showtimer = false;
//                                           });

//                                           // Alert(
//                                           //         context: context,
//                                           //         title: 'Done',
//                                           //         style: AlertStyle(
//                                           //           isCloseButton: true,
//                                           //           isButtonVisible: false,
//                                           //           titleStyle: TextStyle(
//                                           //             color: Colors.white,
//                                           //             fontSize: 30.0,
//                                           //           ),
//                                           //         ),
//                                           //         type: AlertType.success)
//                                           //     .show();
//                                         },
//                                         textStyle: TextStyle(
//                                             fontSize: 50.0,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   )
//                                 : SizedBox(
//                                     height: 5.0,
//                                   ),
// //
//                           ],
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   CircularProgressIndicator(
//                                     backgroundColor: Colors.deepOrange,
//                                   )
//                                 ].where((c) => c != null).toList(),
//                               )
//                             ]),
//                   isResend
//                       ? FadeAnimation(
//                           1.6,
//                           Center(
//                             child: ButtonWidget(
//                               btnText: "Resend",
//                               onClick: () async {
//                                 setState(() {
//                                   isResend = false;
//                                   showtimer = true;
//                                   isLoading = true;
//                                 });
//                                 await authservice.registerWithPhoneNo(
//                                     phonenumber: cellnumberController.text);
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                               },
//                             ),
//                           ),
//                         )
//                       // ? Container(
  //     margin: EdgeInsets.only(top: 40, bottom: 5),
  //     child: Padding(
  //         padding:
  //             const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: new ElevatedButton(
  //           onPressed: () async {
  //             setState(() {
  //               isResend = false;
  //               showtimer = true;
  //               isLoading = true;
  //             });
  //             await authservice.registerWithPhoneNo(
  //                 phonenumber: cellnumberController.text);
  //             setState(() {
  //               isLoading = false;
  //             });
  //           },
  //           child: new Container(
  //             padding: const EdgeInsets.symmetric(
  //               vertical: 15.0,
  //               horizontal: 15.0,
  //             ),
  //             child: new Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 new Expanded(
  //                   child: Text(
  //                     "Resend Code",
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )))
  // : Column()
  //                     : Column(),
  //               ],
  //             ),
  //           ),
  //         )
  //       ]));
  // }
}

// class Skills {
//   int id;
//   String title;

//   Skills({this.id, this.title});

//   static List<Skills> getskills() {
//     return <Skills>[
//       Skills(id: 1, title: "Plumber"),
//       Skills(id: 2, title: "Electrician"),
//       Skills(id: 3, title: "Painter"),
//       Skills(id: 4, title: "Carpenter"),
//       Skills(id: 5, title: "Cleaner"),
//       Skills(id: 5, title: "Gardner"),
//     ];
//   }
// }
