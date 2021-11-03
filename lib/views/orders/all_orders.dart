import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/views/orders/active_orders.dart';
import 'package:laundry_app/views/orders/previous_orders.dart';

class MyOrders extends StatefulWidget {
  final String servicetype;
  final String showScreen;
  final Jobs job;
  //final String
  MyOrders(
      {required this.servicetype, required this.showScreen, required this.job});
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'Active Orders',
    'Previous Orders',
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    // final jobProvider = Provider.of<PostedJobProvider>(context, listen: false);
    // jobProvider.changeservicetype = widget.servicetype;
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 6.0,
        title: Text("My orders"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.filter_sharp,
        //       color: Colors.grey[300],
        //     ),
        //     onPressed: () => {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => JobFilter(),
        //         ),
        //       ),
        //     },
        //   ),
        //   // IconButton(
        //   //   icon: Icon(
        //   //     Icons.add_call,
        //   //     color: Colors.white,
        //   //   ),
        //   //   onPressed: () => {
        //   //     showDialog(
        //   //         context: context,
        //   //         builder: (BuildContext context) {
        //   //           return AdvanceCustomAlert();
        //   //         })
        //   //   },
        //   // ),
        // ],

        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.calendar_today,
                  size: 35,
                ),
                text: ('${categories[0]}'),
              ),

              Tab(
                icon: Icon(
                  Icons.calendar_today,
                  size: 35,
                ),
                text: ('${categories[1]}'),
              ),

              // Tab(
              //   text: ('Outside Pokhara-Lekhnath'),
              // ),
            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          Activeorders(
            job: widget.job,
            screen: widget.showScreen,
          ),

          Previousorders(
            job: widget.job,
            screen: widget.showScreen,
          ),

          // NestedTabBar(),
          // NestedTabBar(),
        ],
        controller: _tabController,
      ),
    );
  }
}
