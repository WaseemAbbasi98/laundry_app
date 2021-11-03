import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/views/orders/all_orders.dart';
import 'package:laundry_app/views/orders/track_order.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/rounded_image_widget.dart';
import 'package:provider/provider.dart';

class PostedJobDetail extends StatefulWidget {
  final Jobs jobs;
  PostedJobDetail({required this.jobs});

  @override
  _PostedJobDetailState createState() => _PostedJobDetailState();
}

class _PostedJobDetailState extends State<PostedJobDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String url;
  late String jobtype;
  late String showScreen;
  bool toogleimgcontainer = false;
  int click = 0;

  String imgurl =
      "https://w7.pngwing.com/pngs/639/452/png-transparent-computer-icons-avatar-user-profile-people-icon-child-face-heroes.png";

  @override
  void initState() {
    super.initState();
    final userprovider = Provider.of<UserType>(context, listen: false);

    // print(widget.showScreen);
    showScreen = userprovider.usertype;

    // if (jobtype == 'Other') {
    //   toogleimgcontainer = true;
    // }
  }

  String btnText = 'TRACK ORDER';
  bool offerboxshow = false;
  bool btnshow = false;
  bool allOfferbtn = false;
  bool btnpress = false;
  @override
  Widget build(BuildContext context) {
    // if (showScreen == 'owner') {
    //   if (btnpress) {
    //     setState(() {
    //       btnshow = false;
    //     });
    //   } else {
    //     setState(() {
    //       btnshow = true;
    //     });
    //   }
    // } else if (showScreen == 'client') {
    //   setState(() {
    //     allOfferbtn = true;
    //   });
    // }
    // setState(() {
    //   url = widget.jobs.imageUrl;
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detial'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    // final uprovider = Provider.of<MyUser>(context, listen: false);
    final uprovider = Provider.of<UserProvider>(context, listen: false);
    final jobProvider = Provider.of<PostedJobProvider>(context, listen: false);

    final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    setState(() {
      user_id = widget.jobs.posterid;
    });
    String userimg;
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: StreamBuilder<QuerySnapshot>(
                  stream: uprovider.users,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text("Loading...");
                      default:
                        // return ListView.builder(
                        //     itemCount: snapshot.data.docs.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot usnapshot = snapshot.data!.docs[0];
                        String img = usnapshot['picture'];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 6.0, color: Colors.grey)
                                  ]),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Order Budget ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      Text(
                                        widget.jobs.budget.toString(),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              child: Container(
                                width: 150,
                                height: 7,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.jobs.title,
                              style: TextStyle(fontSize: 20, height: 1.5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                img != ''
                                    ? RoundedImage(
                                        size: Size.fromWidth(80),
                                        imagePath: usnapshot['picture'] != ""
                                            ? usnapshot['picture']
                                            : imgurl)
                                    : Icon(Icons.person),

                                //               Container(
                                //                 width: 40,
                                //                 height: 40,
                                //                 decoration: BoxDecoration(
                                //                     shape: BoxShape.circle,
                                //                     image: DecorationImage(
                                //                         image: url != null
                                // ? NetworkImage(
                                //     url,

                                //   ):
                                //                             AssetImage(workers[3].imageUrl),
                                //                         fit: BoxFit.cover)),
                                //               ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Order BY",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      usnapshot['name'] ?? "",
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
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // _divider(),
                            Divider(
                              color: Colors.grey,
                              // height: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.place,
                                  color: kPrimaryColor,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      //color: Colors.red,
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "LOCATION",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontFamily: 'Quicksand',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            widget.jobs.location,
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: Align(
                                //     //alignment: Alignment.topLeft,
                                //     child: Text(
                                //       'VIEW ON MAP',
                                //       style: TextStyle(
                                //         fontSize: 14,
                                //         color: deepOrangelightColor,
                                //         fontFamily: 'Quicksand',
                                //         //letterSpacing: 1.5,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            _divider(),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Icon(
                                  Icons.calendar_today,
                                  color: kPrimaryColor,
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "POSTED DATE",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.jobs.postedDate,
                                      style: const TextStyle(
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
                            ),

                            _divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ITEMS DETAIL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  widget.jobs.detail,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      height: 2),
                                  //textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        );
                      // });
                    }
                  }),
            ),
          ),
          ButtonWidget(
            btnText: btnText,
            onClick: () {
              // if (click == 0) {
              //   jobProvider.updatejobstatus(widget.jobs.jobId, 'Confirmed');
              //   orderprovider.changeorderby = widget.jobs.posterid;
              //   orderprovider.changeorderjobid = widget.jobs.jobId;
              //   // orderprovider
              //   //         .chageorderto =
              //   //     snapshot
              //   //         .data[index]
              //   //         .senderid;
              //   // orderprovider
              //   //         .changeorderbudget =
              //   //     snapshot
              //   //         .data[index]
              //   //         .budget;
              //   orderprovider.changepaymentstatus = 'Due';
              //   orderprovider.changestatus = 'active';
              //   var value = DateTime.now();
              //   var formattedDate = "${value.day}-${value.month}-${value.year}";
              //   orderprovider.changeorderdate = formattedDate.toString();
              //   orderprovider.saveorders();
              //   orderprovider.changeorderjobid = widget.jobs.jobId;
              //   print('orderjob id ....');
              //   print(orderprovider.orderjobid);
              //   setState(() {
              //     click = 1;
              //   });
              // }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrackOrderPage(
                            servicetype: widget.jobs.servicetype,
                            job: widget.jobs,
                          )));

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => MyOrders(
              //               servicetype: widget.jobs.servicetype,
              //               job: widget.jobs,
              //               showScreen: 'client',
              //             )));
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

Widget _divider() {
  return Column(
    children: const [
      SizedBox(
        height: 20,
      ),
      // _divider(),
      Divider(
        color: Colors.grey,
        // height: 50,
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}

// Widget _offerbox() {
//   return Column(
//     children: [
//       SizedBox(
//         height: 30.0,
//       ),
//       Text('hellow wolrd',
//           style: TextStyle(color: Colors.black, fontSize: 60.0)),
//     ],
//   );
// }

// import 'package:Hunarmand_signIn_Ui/Models/posted_job_model.dart';
// import 'package:Hunarmand_signIn_Ui/utils/color.dart';
// import 'package:flutter/material.dart';

// class PostedJobDetail extends StatefulWidget {
//   PostedJobDetail({Key key}) : super(key: key);

//   @override
//   _PostedJobDetailState createState() => _PostedJobDetailState();
// }

// class _PostedJobDetailState extends State<PostedJobDetail> {
//   @override
//   Widget build(BuildContext context) {
//     //PostedJob posted_job = new PostedJob();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: deepOrangeColor,
//         elevation: 0,
//         title: Text("HUNARMAND"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.notifications,
//               color: Colors.white,
//             ),
//             onPressed: () => {},
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           Container(
//             alignment: Alignment(0.0, -0.40),
//             height: 60.0,
//             color: Colors.white,
//             child: Text(
//               'Job Detail',
//               style: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0.0),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.0),
//                 boxShadow: [BoxShadow(blurRadius: 6.0, color: Colors.grey)]),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Job Budget Estimated',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: 'Quicksand',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     posted_job[1].budget,
//                     style: TextStyle(
//                         color: Colors.deepOrange,
//                         fontFamily: 'Quicksand',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 40.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.0),
//             child: Text(
//               posted_job[1].detail,
//               style: TextStyle(
//                   color: Colors.grey[700],
//                   fontFamily: 'Quicksand',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25.0),
//             ),
//           ),
//           Container(
//             color: Colors.grey[500],
//             child: Column(
//               children: [
//                 Container(child:
//                 Row(children: [
//                   Row(children: [

//                   ],)
//                 ],)
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
