import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/constants/style.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/services/authservice.dart';
import 'package:laundry_app/views/authenticate/sign_in.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_dialogebox.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final authservice = new AuthService();
  // final _formKey = GlobalKey<FormState>();
  String? useremail = '';
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController cellnumberController =
      new TextEditingController();
  final TextEditingController skillcotroller = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordcotroller = new TextEditingController();
  // CountDownController _controller = CountDownController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  bool _isObscure = true;

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';
  bool showtimer = false;
  final _formkey = GlobalKey<FormState>();
  // final authservice = new AuthService();
  String error = '';
  String phonenumber = '';
  String skill = '';
  String name = '';
  String email = '';
  String address = '';
  String password = '';
  bool isSpin = false;
  bool isworker = false;
  // List<Skills> skilllist;
  // Skills seletedskill;
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

  bool validatePawssword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validatesimpletext(String value) {
    String pattern = r'^[a-zA-Z]+(\s[a-zA-Z]+)?$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
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
                      Text(
                        "SignUp",
                        style: kAuthTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create Account here",
                        style: kAuthTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        // color: Colors.deepOrange,
                        onPressed: () {
                          print('login tap');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignIn(
                                      email: '',
                                    )),
                          );
                        },
                        child: Text(
                          "Login",
                          style: kAuthTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Already have account",
                        style: kAuthTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: kContainerBoxDecoration,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
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
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter your name',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: 'Name'),
                                  onChanged: (val) {
                                    setState(() {
                                      print(validatesimpletext(val));
                                      name = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    if (validatesimpletext(value) == false) {
                                      return 'Only letter are accepted..';
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
                                  controller: addressController,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter your City',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: 'City'),
                                  onChanged: (val) {
                                    setState(() {
                                      address = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a City';
                                    }
                                    if (validatesimpletext(value) == false) {
                                      return 'Only letter are accepted..';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: TextFormField(
                                    enabled: !isLoading,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    decoration: InputDecoration(
                                        hintText: 'Enter your email',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelText: 'Email'),
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter  email address';
                                      }
                                      if (validateEmail(value) == false) {
                                        return 'Please enter valid email address';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  controller: passwordcotroller,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  obscureText: _isObscure,
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
                                    }
                                    if (validatePawssword(value) == false) {
                                      return 'Please enter valid password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              FlutterPwValidator(
                                  controller: passwordcotroller,
                                  minLength: 8,
                                  uppercaseCharCount: 1,
                                  numericCharCount: 1,
                                  specialCharCount: 1,
                                  width: 400,
                                  height: 150,
                                  successColor: kPrimaryColor,
                                  onSuccess: () {}),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: TextFormField(
                                    enabled: !isLoading,
                                    maxLength: 11,
                                    keyboardType: TextInputType.phone,
                                    controller: cellnumberController,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) => node.unfocus(),
                                    decoration: const InputDecoration(
                                        hintText: 'Enter 11 digit Cell Number',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelText: 'Cell Number'),
                                    onChanged: (val) {
                                      setState(() {
                                        phonenumber = val;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a cell number';
                                      } else if (value.length < 11 ||
                                          value.length > 11) {
                                        return 'invalid phone number';
                                      } else if (value.isNotEmpty &&
                                          value.length == 11) {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Center(
                                child: ButtonWidget(
                                  btnText: "Register",
                                  onClick: () async {
                                    if (_formkey.currentState!.validate()) {
                                      try {
                                        User authUser = await authservice
                                            .registerWithEmailandPassword(
                                                name: name,
                                                phone: phonenumber,
                                                type: usertypeprovider.usertype,
                                                city: address,
                                                email: email,
                                                password: password);
                                        useremail = authUser.email;
                                        print(useremail);
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
                                                      title: 'Register Error',
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

                                          // usertypeprovider.usertype == 'client'
                                          //     ? Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 HomeDashboard(
                                          //                   useremail: useremail,
                                          //                 )),
                                          //       )
                                          //     : Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 OwnerDashboard(
                                          //                   showScreen: '',
                                          //
                                          //         )));
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignIn(
                                                    email: useremail.toString(),
                                                    // useremail: useremail,
                                                  )),
                                        );
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // OrDivider(),
                        // Row(
                        //   children: [
                        //     Center(
                        //       child: Text('Already have account..'),
                        //     ),
                        //     FlatButton(child: Text('login'), onPressed: () {}),
                        //   ],
                        // )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     SocialIcon(
                        //       iconSrc: "assets/icons/facebook.svg",
                        //       press: () {},
                        //     ),
                        //     SocialIcon(
                        //       iconSrc: "assets/icons/google-plus.svg",
                        //       press: () {},
                        //     ),
                        //   ],
                        // )
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
