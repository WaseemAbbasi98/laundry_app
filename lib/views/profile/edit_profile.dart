import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/models/user.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_formfeild.dart';
import 'package:laundry_app/widgets/rounded_image_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String uid;

  EditProfilePage({required this.uid});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  late File image;
  ImagePicker picker = ImagePicker();
  String imgurl = '';
  String name = '';
  String emial = '';
  String mobileno = '';
  String location = '';
  String cnic = '';

  bool loading = false;
  String immatch =
      "https://w7.pngwing.com/pngs/639/452/png-transparent-computer-icons-avatar-user-profile-people-icon-child-face-heroes.png";

  // FirestoreService firestoreService = ;
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      // bottomNavigationBar: followButton(),
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(fontSize: 20.0)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                color: kPrimaryColor,
              ),
              clipper: GetClipper(),
            ),
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: userprovider.users,
                  builder: (context, usersnapshot) {
                    // switch (usersnapshot.connectionState) {
                    // case ConnectionState.waiting:
                    //   return const Text("Loading...");
                    // case ConnectionState.done:
                    if (usersnapshot.hasData) {
                      DocumentSnapshot usnapshot = usersnapshot.data!.docs[0];

                      String img = usnapshot['picture'];
                      //
                      //Worker worker = workersnapshot.data;

                      return formContent(
                          usnapshot: usnapshot, userprovider: userprovider);
                    } else {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }

                    //   case ConnectionState.none:
                    //     // TODO: Handle this case.
                    //     return Center();
                    //     break;
                    //   case ConnectionState.active:
                    //     // TODO: Handle this case.
                    //     return Center();
                    //     break;
                    //   default:
                    //     return Center();
                    // }
                  }),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            //   child: TextFormField(
            //     // enabled: !isLoading,
            //     // controller: nameController,
            //     textInputAction: TextInputAction.next,
            //     // onEditingComplete: () => node.nextFocus(),
            //     decoration: const InputDecoration(
            //         hintText: 'Enter your name',
            //         floatingLabelBehavior: FloatingLabelBehavior.never,
            //         labelText: 'Name'),
            //     onChanged: (val) {
            //       setState(() {
            //         name = val;
            //       });
            //     },
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Please enter a name';
            //       } else {
            //         return null;
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget formContent(
      {required DocumentSnapshot usnapshot,
      required UserProvider userprovider}) {
    final node = FocusScope.of(context);
    final TextEditingController nameController = new TextEditingController();

    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            RoundedImage(
                // imgtype: user.imageUrl != null ? true : false,
                size: Size.fromRadius(80),
                imagePath: usnapshot['picture'] != imgurl
                    ? usnapshot['picture']
                    : imgurl),
            !loading
                ? Positioned(
                    top: 40.0,
                    right: 5.0,
                    child: InkWell(
                      onTap: () {
                        _showChoiceDialoge(context);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      // onTap: () {
                      //   showModalBottomSheet(
                      //       context: context,
                      //       builder: ((builder) => UploadImage()));
                      // },
                    ),
                  )
                : const Positioned(
                    top: 50.0,
                    right: 50.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 30.0,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                FormInputFeild(
                  initialvalue: usnapshot['name'] ?? '',
                  hintText: 'My Name',
                  labelText: 'Name',
                  onvalchange: (val) {
                    name = val;
                    val != null
                        ? userprovider.changename = val
                        : userprovider.changename = usnapshot['name'];
                    // setState(() {
                    //   name = val;
                    // });
                  },
                  keyboardtype: TextInputType.text,
                ),
                SizedBox(
                  height: 10.0,
                ),
                // FormInputFeild(
                //   initialvalue: worker.skill != ''
                //       ? worker.skill
                //       : " ",
                //   hintText: 'My Skill',
                //   labelText: 'Skill',
                //   onvalchange: (val) {
                //     val != null
                //         ? workerprovider.changeskill =
                //             val
                //         : workerprovider.changeskill =
                //             worker.skill;
                //   },
                // ),
                SizedBox(
                  height: 10.0,
                ),
                // FormInputFeild(
                //   initialvalue: user.mobileNo ?? '',
                //   hintText: 'My Mobile Number',
                //   labelText: 'Mobile Number',
                // ),
                SizedBox(
                  height: 10.0,
                ),
                FormInputFeild(
                  initialvalue: usnapshot['email'] ?? '',
                  hintText: 'My Email Address',
                  labelText: 'Email Address',
                  onvalchange: (val) {
                    emial = val;
                    val != null
                        ? userprovider.changeemail = val
                        : userprovider.changeemail = usnapshot['email'];
                  },
                  keyboardtype: TextInputType.emailAddress,
                ),
                FormInputFeild(
                  initialvalue: usnapshot['mobileno'] ?? '',
                  hintText: 'My Mobile Number',
                  labelText: 'Mobile Number',
                  readonly: true,
                  keyboardtype: TextInputType.phone,
                  // onvalchange: (val) {
                  //   setState(() {
                  //     emial = val;
                  //   });
                  // },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FormInputFeild(
                  initialvalue: usnapshot['cnic'] ?? 'cnic',
                  hintText: 'My CNIC Number',
                  labelText: 'CNIC Number',
                  keyboardtype: TextInputType.phone,
                  onvalchange: (val) {
                    cnic = val;
                    val != ''
                        ? userprovider.changecnic = val
                        : userprovider.changecnic = usnapshot['cnic'];
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FormInputFeild(
                  initialvalue: usnapshot['address'] ?? 'location',
                  hintText: 'My Location',
                  labelText: 'Location',
                  onvalchange: (val) {
                    print('value at location ');
                    print(val);
                    location = val;
                    val != null
                        ? userprovider.changeaddress = val
                        : userprovider.changeaddress = usnapshot['address'];
                  },
                  keyboardtype: TextInputType.text,
                ),
                SizedBox(
                  height: 10.0,
                ),
                // FormInputFeild(
                //   hintText: 'Description',
                //   //labelText: 'Description',
                //   feildHeight: 10,
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
              ],
            ),
          ),
        ),
        ButtonWidget(
            btnText: 'UPDATE',
            onClick: () {
              // name != null
              //     ? userprovider.changename = name
              //     : userprovider.changename =
              //         user.name;
              // cnic != null
              //     ? userprovider.changecnic = cnic
              //     : userprovider.changecnic =
              //         user.cnic;
              // emial != null
              //     ? userprovider.changeemail = emial
              //     : userprovider.changeemail =
              //         user.email;
              // imgurl != ''
              //     ? userprovider.changepicture = imgurl
              //     : userprovider.changepicture =
              //         usnapshot['picture'];
              print('img url is ::::');
              print(imgurl);
              name != ''
                  ? userprovider.changename = name
                  : userprovider.changename = usnapshot['name'];
              emial != ''
                  ? userprovider.changeemail = emial
                  : userprovider.changeemail = usnapshot['email'];
              cnic != ''
                  ? userprovider.changecnic = cnic
                  : userprovider.changecnic = usnapshot['cnic'];
              location != ''
                  ? userprovider.changeaddress = location
                  : userprovider.changeaddress = usnapshot['address'];
              userprovider.changephoneno = usnapshot['mobileno'];
              userprovider.changetype = usnapshot['type'];
              userprovider.changedpassword = usnapshot['password'];
              userprovider.changepicture = usnapshot['picture'];
              // imgurl != ''
              //     ? userprovider.changepicture = imgurl
              //     : userprovider.changepicture = immatch;
              // _auth.currentUser!.updatePhotoURL(imgurl);
              // .updateProfile(photoURL: imgurl);
              // workerprovider
              //     .updateworkers(widget.uid);
              userprovider.updateusers(widget.uid);
              // print('image url is');
              // print(imgurl);
              print(widget.uid);
              if (!loading) {
                _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  content: Text('Profile updated Successfully'),
                  duration: Duration(seconds: 3),
                ));
                Navigator.pop(context);
              } else {
                _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  content: Text('please wait image is uploading... '),
                  duration: Duration(seconds: 3),
                ));
              }
            }),
        SizedBox(
          height: 20.0,
        ),

        // ContactInfo(),
      ],
    );
  }

  void openGallery(BuildContext context) async {
    final picture = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(picture!.path);
    });

    uploadImageToFirebase(image, context);
    Navigator.of(context).pop();
  }

  void openCamera(BuildContext context) async {
    var picture = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = File(picture!.path);
    });

    uploadImageToFirebase(image, context);
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Make a Choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  // IconButton(icon: Icon(Icons.photo_album), onPressed: (){

                  // },),
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadImageToFirebase(
      File _imagepath, BuildContext context) async {
    final userprovider1 = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      loading = true;
    });
    final _storage = FirebaseStorage.instance;
    // final jobProvider = Provider.of<PostedJobProvider>(context, listen: false);

    var fileName = _imagepath.toString();
    if (_imagepath != null) {
      var snapshot = await _storage
          .ref()
          .child('Image/ProfileImage/$fileName')
          .putFile(_imagepath);
      //         UploadTask uploadTask = _storage.p(_image);
      // TaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String img = await snapshot.ref.getDownloadURL();
      if (img != null) {
        setState(() {
          loading = false;
          // if (loading = false) {
          imgurl = img;
          userprovider1.updateuserimg(widget.uid, imgurl);
          print('image in state is');

          print(imgurl);
          // }
        });
      }
      // if (loading = false) {
      //   setState(() {

      //   });
      //   print(img);
      // }

      // imageUrl = await snapshot.ref.getDownloadURL();
      // jobProvider.changeimageurl = imageUrl;
      // if (imageUrl != null) {
      //   // PostJobController _controller = PostJobController();
      //   _controller.setUrl(imageUrl);
      // }
      // print('image url from upload function is......');
      // print(imageUrl);
      // print('image url from provider  function is......');
      // print(imageUrl);
      // return imageUrl;
    } else {
      print('something wrong');
    }
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 3.2);
    path.lineTo(size.width + 115.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
