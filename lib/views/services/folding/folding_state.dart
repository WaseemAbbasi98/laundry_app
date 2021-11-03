import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/views/services/dryclean/kids_services.dart';
import 'package:laundry_app/views/services/dryclean/mens_service.dart';
import 'package:laundry_app/views/services/dryclean/others_services.dart';
import 'package:laundry_app/views/services/dryclean/women_service.dart';
import 'package:laundry_app/views/services/folding/mens_service.dart';
import 'package:laundry_app/views/services/folding/women_service.dart';
import 'package:laundry_app/views/services/ironing/kids_services.dart';
import 'package:laundry_app/views/services/ironing/mens_service.dart';
import 'package:laundry_app/views/services/ironing/women_service.dart';
import 'package:laundry_app/views/services/service_details.dart';
import 'package:laundry_app/views/services/washing/kids_services.dart';
import 'package:laundry_app/views/services/washing/mens_service.dart';
import 'package:laundry_app/views/services/washing/others_services.dart';
import 'package:laundry_app/views/services/washing/women_service.dart';
import 'package:laundry_app/widgets/custom_button.dart';

class FoldingJobsstate extends StatefulWidget {
  final List<String> categories = [
    "Men's",
    "Women's",
  ];

  FoldingJobsstate({Key? key, required this.sType}) : super(key: key);

  final String sType;
  @override
  _FoldingJobsstateState createState() => _FoldingJobsstateState();
}

class _FoldingJobsstateState extends State<FoldingJobsstate>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late int total;
  @override
  void initState() {
    super.initState();
    // total = Joblist().total;
    _nestedTabController =
        TabController(length: widget.categories.length, vsync: this);
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
                    FoldingMensServices(
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
                    FoldingWomenServices(type: widget.sType),
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
          ],
        ),
      ),
    );
  }
}
