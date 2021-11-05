// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:laundry_app/viewmodels/service_model.dart';
import 'package:laundry_app/views/views/StyleScheme.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:laundry_app/widgets/custom_dialogebox.dart';
import 'package:provider/provider.dart';

class TrackOrderPage extends StatefulWidget {
  final Jobs job;
  final String servicetype;
  const TrackOrderPage({Key? key, required this.job, required this.servicetype})
      : super(key: key);

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  String statestatus = 'Confirmed';
  double starrating = 0;
  @override
  Widget build(BuildContext context) {
    final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    final usertypeprovider = Provider.of<UserType>(context, listen: false);
    print('usertype at screen is....');
    print(usertypeprovider.usertype);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Track Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardItem(job: widget.job, status: statestatus),
            // Text(
            //   "Order Number 1001",
            //   style: headingStyle,
            // ),
            // Text(
            //   "Order confirmed. Ready to pick",
            //   style: contentStyle.copyWith(color: Colors.grey, fontSize: 16),
            // ),
            // Divider(
            //   he
            // ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Card(
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13, top: 50),
                        width: 4,
                        height: 400,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          statusWidget(
                              'confirmed',
                              "Confirmed",
                              statestatus == 'Confirmed' ||
                                      statestatus == 'Picked' ||
                                      statestatus == 'Inprocess' ||
                                      statestatus == 'Shipped' ||
                                      statestatus == 'Deliver' ||
                                      statestatus == 'Payment'
                                  ? true
                                  : false),
                          statusWidget(
                              'onBoard2',
                              "Picked Up",
                              statestatus == 'Picked' ||
                                      statestatus == 'Inprocess' ||
                                      statestatus == 'Shipped' ||
                                      statestatus == 'Deliver' ||
                                      statestatus == 'Payment'
                                  ? true
                                  : false),
                          statusWidget(
                              'servicesImg',
                              "In Process",
                              statestatus == 'Inprocess' ||
                                      statestatus == 'Shipped' ||
                                      statestatus == 'Deliver' ||
                                      statestatus == 'Payment'
                                  ? true
                                  : false),
                          statusWidget(
                              'shipped',
                              "Shipped",
                              statestatus == 'Shipped' ||
                                      statestatus == 'Deliver' ||
                                      statestatus == 'Payment'
                                  ? true
                                  : false),
                          statusWidget(
                              'Delivery',
                              "Delivered",
                              statestatus == 'Deliver' ||
                                      statestatus == 'Payment'
                                  ? true
                                  : false),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            usertypeprovider.usertype == 'client'
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // orderprovider.removeorder(id)
                            showRating();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            child: Text(
                              "Rate Service",
                              style: contentStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 10.0,
                  ),
          ],
        ),
      ),
    );
  }

  _cardItem({required Jobs job, var ontap, required String status}) {
    // double _rating = 4.0;
    final usertypeprovider = Provider.of<UserType>(context, listen: false);

    int index;
    if (job.servicetype != '') {
      index = serviceindex(job.servicetype);
      print('service type at order');
      print(job.servicetype);
    } else {
      index = serviceindex('Washing');
    }
    print(index);
    final service = servicelsit[index];
    double _borderRadius = 24.0;
    int budget = job.budget;
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 7,
              width: double.infinity,
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
                    child: Image.asset(
                      service.img,
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    // child: CircleAvatar(
                    //   backgroundImage: AssetImage(
                    //     service.img,
                    //   ),
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
                        title: usertypeprovider.usertype == 'owner'
                            ? job.servicetype
                            : 'Service Type',
                        isfirst:
                            usertypeprovider.usertype == 'owner' ? true : false,
                        status: status,
                        ontap: () {
                          print('button press');
                          print(status);
                          if (status == 'Confirmed') {
                            setState(() {
                              statestatus = 'Picked';
                              print(statestatus);
                            });
                          } else if (statestatus == 'Picked') {
                            setState(() {
                              statestatus = 'Inprocess';
                              print(status);
                            });
                          } else if (statestatus == 'Inprocess') {
                            setState(() {
                              statestatus = 'Shipped';
                            });
                          } else if (statestatus == 'Shipped') {
                            setState(() {
                              statestatus = 'Deliver';
                            });
                          } else if (statestatus == 'Deliver') {
                            setState(() {
                              statestatus = 'Payment';
                            });
                            final usertypeprovider =
                                Provider.of<UserType>(context, listen: false);

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(dialogepadding),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: contentBox(
                                        child: SizedBox(
                                          height: 2,
                                        ),
                                        onTap: () {},
                                        context: context,
                                        title: 'Payment Info',
                                        subtitle: "Total Payment",
                                        amount: widget.job.budget.toString(),
                                        text: 'Collect'),
                                  );
                                });
                          }
                          // if (status == 'Confirmed') {
                          //   setState(() {
                          //     status = 'Picked';
                          //   });
                          // }
                        },
                        description: usertypeprovider.usertype == 'owner'
                            ? ''
                            : job.servicetype),
                    SizedBox(
                      height: 10.0,
                    ),
                    _profileContent(
                        title: 'Scheduled',
                        description: job.postedDate,
                        isfirst: false,
                        status: ''),
                    SizedBox(
                      height: 10.0,
                    ),
                    _profileContent(
                        title: 'Total Cost',
                        description: 'Rs.' + job.budget.toString(),
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

          // ButtonWidget(
          //   btnText: 'Rate',
          //   onClick: () {
          //     // _showRatingAppDialog();
          //     showRating();
          //   },
          // )
          // //
        ],
        //
      ),
    );
  }

  Widget buildRating() => RatingBar.builder(
        initialRating: starrating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
          setState(() {
            starrating = rating;
          });
        },
      );
  void showRating() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(dialogepadding),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Column(
              children: [
                contentBox(
                    onTap: () {},
                    context: context,
                    title: 'Service Rating',
                    subtitle: "Rating:",
                    amount: starrating.toString(),
                    text: 'Submit',
                    child: buildRating()),
              ],
            ),
          ),
        );
      });

  Widget _profileContent(
      {required String title,
      required String description,
      required bool isfirst,
      required String status,
      var ontap}) {
    double _borderRadius = 12.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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

Container statusWidget(String img, String status, bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isActive) ? kPrimaryColor : Colors.white,
              border: Border.all(
                  color: (isActive) ? kPrimaryColor : kPrimaryColor, width: 3)),
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/$img.png"),
                      fit: BoxFit.contain)),
            ),
            Text(
              status,
              style: contentStyle.copyWith(
                  color: (isActive) ? Colors.orange : Colors.black),
            )
          ],
        )
      ],
    ),
  );
}
