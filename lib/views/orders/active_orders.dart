import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:laundry_app/viewmodels/service_model.dart';
import 'package:laundry_app/views/orders/order_details.dart';
import 'package:provider/provider.dart';

late User _loginUser;
String name = '';
bool verified = false;
Color icolorwhite = Colors.white;
Color icolorred = Colors.red;

class Activeorders extends StatefulWidget {
  final Jobs job;
  final String screen;

  Activeorders({required this.job, required this.screen});

  @override
  _ActiveordersState createState() => _ActiveordersState();
}

class _ActiveordersState extends State<Activeorders> {
  FirestoreService _firestoreService = FirestoreService();
  @override
  void initState() {
    _loginUser = FirebaseAuth.instance.currentUser!;
    name = _loginUser.displayName!;
    // status = widget.job.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   status = widget.job.status;
    // });
    final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    final jobprovider = Provider.of<PostedJobProvider>(context, listen: false);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // shrinkWrap: true,
            children: <Widget>[
              //
              SizedBox(height: 20.0),

              SizedBox(height: 10.0),
              StreamBuilder<List<Order>>(
                  //  _firestore
                  //     .collection('posted_projects')
                  //     .where("posted_by", isEqualTo: email)
                  //     .snapshots(),
                  stream: widget.screen == 'client'
                      ? orderprovider.clientorders
                      : orderprovider.orders,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.deepOrange,
                          ),
                        );
                      default:
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  _firestoreService.jobid =
                                      snapshot.data![index].jobId;
                                  // var jobs = Provider.of<List<Jobs>>(context);
                                  // Jobs job = jobs[index];
                                  Order order = snapshot.data![index];
                                  // print(job.postedBy);
                                  // final worker = workers[index];
                                  return _cardItem(
                                      snapshot: order,
                                      job: widget.job,
                                      ontap: () {
                                        print('status at parent level...' +
                                            snapshot
                                                .data![index].paymentstatus);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Orderdetail(
                                                      jobid: snapshot
                                                          .data![index].jobId,
                                                      orderid: snapshot
                                                          .data![index].orderid,
                                                      budget: snapshot
                                                          .data![index]
                                                          .orderbudget,
                                                      payments:
                                                          order.paymentstatus,
                                                      showscreen: widget.screen,
                                                    )));
                                      });
                                  // return _buildListCard(pjobs: postedJobs);
                                }),
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: Image(
                                image: AssetImage('asset/images/noorder.jpeg'),
                              ),
                            ),
                          );
                        }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _cardItem({required Order snapshot, required Jobs job, var ontap}) {
    // double _rating = 4.0;
    int index;
    if (job.servicetype != null) {
      index = serviceindex(job.servicetype);
      print('service type at order');
      print(job.servicetype);
    } else {
      index = serviceindex('Plumber');
    }
    print(index);
    final service = servicelsit[index];
    double _borderRadius = 24.0;
    int budget = snapshot.orderbudget;
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 9,
          //   bottom: 10,
          //   top: 10,
          //   child: CustomPaint(
          //     size: Size(80, 150),
          //     painter: CustomCardShapePainter(
          //         _borderRadius, worker.startColor, worker.endColor),
          //   ),
          // ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 10.0, left: 5.0),
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        service.img,
                      ),
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  // Text('Varification',
                  //     style: TextStyle(
                  //         color: Colors.grey,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold)),
                ],
              ),
              //SizedBox(width: 10.0),

              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // _rowwidget(title: 'Service', subtitle: 'hiii'),
                    _profileContent(
                        title: job.servicetype,
                        isfirst: true,
                        status: job.status,
                        ontap: () {},
                        description: ''),
                    SizedBox(
                      height: 10.0,
                    ),
                    _profileContent(
                        title: 'Scheduled',
                        description: snapshot.date,
                        isfirst: false,
                        status: ''),
                    SizedBox(
                      height: 10.0,
                    ),
                    _profileContent(
                        title: 'Total Cost',
                        description: 'Rs.' + snapshot.orderbudget.toString(),
                        isfirst: false,
                        status: ''),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Center(
                    //   child: _profileContent(
                    //       title: 'make group',
                    //       description: '',
                    //       ontap: () {
                    //         print('make group tap');
                    //       },
                    //       isfirst: true),
                    // )
                  ],
                ),
              ),
            ],
          ),
          //
        ],
        //
      ),
    );
  }

  Widget _profileContent(
      {required String title,
      required String description,
      required bool isfirst,
      required String status,
      var ontap}) {
    double _borderRadius = 12.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              // fontFamily: 'Avenir',
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 140.0,
        ),
        isfirst
            ? InkWell(
                onTap: ontap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.deepOrange,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Avenir',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Text(
                description,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Avenir',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }

  int serviceindex(String servicetype) {
    // int index;
    switch (servicetype) {
      case 'Electrician':
        return 0;
        break;
      case 'Plumber':
        return 1;
        break;
      case 'Painter':
        return 2;
        break;
      case 'Carpanter':
        return 3;
        break;
      case 'Cleaner':
        return 4;
        break;
      case 'Gardner':
        return 5;
        break;
      default:
        return 0;
    }
  }
}
