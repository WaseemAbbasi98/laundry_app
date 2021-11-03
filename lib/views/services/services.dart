import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/views/services/service_details.dart';
import 'package:laundry_app/views/services/washing/kids_services.dart';
import 'package:laundry_app/views/services/washing/mens_service.dart';
import 'package:laundry_app/views/services/washing/others_services.dart';
import 'package:laundry_app/views/services/washing/washing_service.dart';
import 'package:laundry_app/views/services/washing/women_service.dart';
import 'package:laundry_app/widgets/custom_button.dart';

class Jobsstate extends StatefulWidget {
  final List<String> categories = [
    "Men's",
    "Women's",
    "Kid's",
    "Other's",
  ];

  Jobsstate({Key? key, required this.sType}) : super(key: key);

  final String sType;
  @override
  _JobsstateState createState() => _JobsstateState();
}

class _JobsstateState extends State<Jobsstate> with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late int total;
  @override
  void initState() {
    super.initState();
    // total = Joblist().total;
    _nestedTabController =
        new TabController(length: widget.categories.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String stype =
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.sType,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          padding: EdgeInsets.all(10.0),
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          isScrollable: false,
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          tabs: <Widget>[
            Tab(
              text: widget.categories[0],
            ),
            Tab(
              text: widget.categories[1],
            ),
            Tab(
              text: widget.categories[2],
            ),
            Tab(
              text: widget.categories[3],
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight * 0.85,
        // margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: TabBarView(
          controller: _nestedTabController,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    MensServices(
                      type: widget.sType,
                    ),

                    ButtonWidget(
                        btnText: 'Next',
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Jobdetail(
                                        serviceType: widget.sType,
                                      )));
                        }),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                  ],
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    WomenServices(type: widget.sType),
                    // selectedIndex == 2 ? Text('index2') : Text('index3'),
                    const SizedBox(
                      height: 10.0,
                    ),

                    ButtonWidget(
                        btnText: 'Next',
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Jobdetail(
                                        serviceType: widget.sType,
                                      )));
                        }),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                  ],
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    KidsServices(
                      type: widget.sType,
                    ),
                    // selectedIndex == 2 ? Text('index2') : Text('index3'),
                    const SizedBox(
                      height: 10.0,
                    ),

                    ButtonWidget(
                        btnText: 'Next',
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Jobdetail(
                                        serviceType: widget.sType,
                                      )));
                        }),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                  ],
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    OtherServices(type: widget.sType),
                    // selectedIndex == 2 ? Text('index2') : Text('index3'),
                    const SizedBox(
                      height: 10.0,
                    ),

                    ButtonWidget(
                        btnText: 'Next',
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Jobdetail(
                                        serviceType: widget.sType,
                                      )));
                        }),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                  ],
                ),
              ],
            ),

            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8.0),
            //     color: Colors.blueGrey[300],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
