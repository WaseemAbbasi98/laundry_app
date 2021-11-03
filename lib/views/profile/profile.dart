import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/views/profile/components/about_info.dart';
import 'package:laundry_app/views/profile/components/contact_info.dart';
import 'package:laundry_app/views/profile/edit_profile.dart';
import 'package:laundry_app/widgets/rounded_image_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  final bool showtop;
  ProfilePage({required this.uid, required this.showtop});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imgurl =
      "https://w7.pngwing.com/pngs/639/452/png-transparent-computer-icons-avatar-user-profile-people-icon-child-face-heroes.png";
  @override
  void initState() {
    // Worker worker;
    print(widget.uid);
    // final workerprovider = Provider.of<WorkerProvider>(context, listen: false);
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    // workerprovider.changeworkerid = widget.uid;
    // userprovider.changeuserid = widget.uid;
    // workerprovider.worker;
    // workerprovider.loadAll(worker);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
        // final workerprovider = Provider.of<WorkerProvider>(context, listen: false);
        final userprovider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      // bottomNavigationBar: followButton(),
      appBar: AppBar(
        title: widget.showtop
            ? Text('Profile', style: TextStyle(fontSize: 20.0))
            : Text('My Profile', style: TextStyle(fontSize: 20.0)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          widget.showtop
              ? const SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditProfilePage(uid: widget.uid)));
                  },
                )
        ],
      ),
      //   body: Container(
      //     child: Center(
      //       child: Text('profilepage'),
      //     ),
      //   ),
      // );
      body: Stack(children: <Widget>[
        ClipPath(
          child: Container(
            color: kPrimaryColor,
          ),
          clipper: GetClipper(),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: userprovider.users,
            builder: (context, usersnapshot) {
              // switch (usersnapshot.connectionState) {
              // case ConnectionState.waiting: return new Text("Loading...");
              // default:

              // switch (usersnapshot.connectionState) {
              //   case ConnectionState.waiting:
              //     return new Text("Loading...");
              //     break;
              //   case ConnectionState.done:
              //   case ConnectionState.active:
              if (usersnapshot.hasData) {
                return ListView.builder(
                    itemCount: usersnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot usnapshot =
                          usersnapshot.data!.docs[index];

                      String img = usnapshot['picture'];
                      print('user img is ........');
                      print(img);
                      return Stack(children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Positioned(
                                width: MediaQuery.of(context).size.width,
                                top: MediaQuery.of(context).size.height / 16.0,
                                child: img != null
                                    ? RoundedImage(
                                        imagePath:
                                            usnapshot['picture'] != imgurl
                                                ? usnapshot['picture']
                                                : imgurl)
                                    : Icon(Icons.person)),
                            SizedBox(
                              height: 18.0,
                            ),
                            Center(
                              child: Text(
                                usnapshot['name'] ?? "worker name",
                                // snapshot.data[index].name,

                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Center(
                              child: Text(
                                usnapshot['mobileno'] ?? "worker Phone",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: 50.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Divider(
                              height: 15,
                              color: Colors.grey,
                            ),
                            AboutInfo(
                              location: usnapshot['address'] ?? 'N/A',
                              dob: usnapshot['cnic'] ?? 'N/A',
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Divider(
                              height: 15,
                              color: Colors.grey,
                            ),
                            ContactInfo(
                              email: usnapshot['email'] ?? 'n/a',
                              mobileno: usnapshot['mobileno'] ?? 'n/a',
                            ),
                          ],
                        ),
                      ]);
                    });
              } else {
                return Center(
                  child: Text('OOPs something went wrong...'),
                );
              }
              //     break;
              //   case ConnectionState.none:
              //     // TODO: Handle this case.
              //     break;
              //   default:
              //     return

              //   // TODO: Handle this case.
              //   // break;
              // }
            }),
      ]),
    );
  }

  // Widget _jobdetailinfo({int heading, String subheading, Color hColor}) {
  //   return Column(
  //     children: <Widget>[
  //       Text(
  //         heading.toString(),
  //         style: TextStyle(
  //           color: hColor,
  //           fontSize: 22.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 5.0,
  //       ),
  //       Text(
  //         subheading,
  //         style: TextStyle(
  //           color: Colors.blueGrey,
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildTripCard(BuildContext context, DocumentSnapshot snapshot) {
    String img = snapshot['imageurl'];
    return Stack(children: [
      Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 16.0,
              child: img != null
                  ? RoundedImage(
                      imagePath: snapshot['imageurl'] != ""
                          ? snapshot['imageurl']
                          : imgurl)
                  : Icon(Icons.person)),
          SizedBox(
            height: 18.0,
          ),
          Center(
            child: Text(
              snapshot['name'] ?? "worker name",
              // snapshot.data[index].name,

              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              snapshot['mobileno'] ?? "worker Phone",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),

          // SizedBox(
          //   height: 20.0,
          // ),
          // Divider(
          //   height: 15,
          //   color: Colors.grey,
          // ),
          AboutInfo(
            location: snapshot['location'] ?? 'n/a',
            dob: snapshot['skill'] ?? 'n/a',
          ),
          Divider(
            height: 15,
            color: Colors.grey,
          ),
          ContactInfo(
            email: snapshot['email'] ?? 'n/a',
            mobileno: snapshot['mobileno'] ?? 'n/a',
          ),
        ],
      ),
    ]);
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
