import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/views/corders/posted_order_details.dart';
import 'package:laundry_app/views/home/drawer.dart';
import 'package:provider/provider.dart';

class OwnerDashboard extends StatefulWidget {
  final String showScreen;
  OwnerDashboard({required this.showScreen});
  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<PostedJobProvider>(context);

    List<String> location;
    List<String> orderId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // elevation: 0,
        title: Text('Laundry Management System'),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: Column(
            // shrinkWrap: true,
            children: <Widget>[
              // Stack(
              //   children: <Widget>[
              //     _top(),
              //     //
              //   ],
              // ),
              //
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                  ),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'All ORDERS',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  )),
              const SizedBox(height: 10.0),
              StreamBuilder<List<Jobs>>(
                  stream: jobProvider.allorders,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    // print(snapshot.data);
                    else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              //primary: false,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 8.0,
                              //shrinkWrap: true,
                            ),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              location =
                                  (snapshot.data![index].location).split(',');
                              orderId = snapshot.data![index].jobId.split("-");
                              print(orderId.length);
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 10.0,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Colors.deepOrange
                                              .withOpacity(0.5),
                                          image: const DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'asset/images/user.png'))),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data![index].title,
                                            style: const TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            margin: EdgeInsets.only(left: 60.0),
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'Order Id:',
                                                  style: TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Colors.grey),
                                                ),
                                                // SizedBox(
                                                //   width: 5.0,
                                                // ),
                                                Flexible(
                                                  child: Text(
                                                    'LMS-${orderId[0]}',
                                                    // pjobs.offers.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.0,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 40.0),
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.place,
                                                    size: 20.0,
                                                  ),
                                                  // SizedBox(
                                                  //   width: .0,
                                                  // ),
                                                  Flexible(
                                                    child: Text(
                                                      location[0],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Quicksand',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
                                                          color: Colors.grey),
                                                      // textAlign: TextAlign.center,
                                                      // maxLines: 1,
                                                      // overflow:
                                                      //     TextOverflow.visible,
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                      // softWrap: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ]),
                                    // SizedBox(height: 15.0),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostedJobDetail(
                                                        jobs: snapshot
                                                            .data![index],
                                                        // showScreen:
                                                        //     widget.showScreen,
                                                      )));
                                        },
                                        child: Container(
                                            height: 100,
                                            width: 200.0,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor
                                                  .withOpacity(0.8),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'View Detail',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Quicksand'),
                                              ),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                // margin: cardIndex.isEven
                                //     ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
                                //     : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0),
                              );
                            }),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Image(
                            image:
                                AssetImage('assets/images/no-data-found.png'),
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
