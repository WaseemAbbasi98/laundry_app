import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:laundry_app/viewmodels/service_model.dart';
import 'package:laundry_app/views/orders/order_state.dart';
import 'package:provider/provider.dart';

late User _loginUser;
String name = '';
bool verified = false;
Color icolorwhite = Colors.white;
Color icolorred = Colors.red;

class Orderdetail extends StatefulWidget {
  final jobid;
  final orderid;
  final budget;
  final payments;
  final showscreen;
  Orderdetail(
      {this.jobid, this.orderid, this.budget, this.payments, this.showscreen});

  @override
  _OrderdetailState createState() => _OrderdetailState();
}

class _OrderdetailState extends State<Orderdetail> {
  // FirestoreService _firestoreService = FirestoreService();
  String status = '';
  String payStatus = '';

  @override
  void initState() {
    _loginUser = FirebaseAuth.instance.currentUser!;
    name = _loginUser.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService().jobid = widget.jobid;
    var jobs = Provider.of<List<Jobs>>(context, listen: false);
    // for (int i = 0; i < jobs.length; i++) {
    //   print(jobs[i].budget);
    // }
    final jobProvider = Provider.of<PostedJobProvider>(context, listen: false);
    final orderprovider = Provider.of<OrderProvider>(context, listen: false);
    payStatus = widget.payments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        // child: StreamBuilder<List<Jobs>>(
        //   //  _firestore
        //   //     .collection('posted_projects')
        //   //     .where("posted_by", isEqualTo: email)
        //   //     .snapshots(),
        //   stream: jobProvider.jobs,
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       print(snapshot.error.toString());
        //       return Center(
        //         child: CircularProgressIndicator(
        //           backgroundColor: Colors.deepOrange,
        //         ),
        //       );
        //     }
        //     return
        child: Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                Jobs job = jobs[index];

                return _cardItem(
                    job: job,
                    jobProvider: jobProvider,
                    orderprovider: orderprovider);
                // return _buildListCard(pjobs: postedJobs);
              }),
        ),
      ),
    );
  }

  _cardItem(
      {required Jobs job,
      required PostedJobProvider jobProvider,
      required OrderProvider orderprovider}) {
    int index;
    if (job.servicetype != '') {
      index = serviceindex(job.servicetype);
      print('service type at order');
      print(job.servicetype);
    } else {
      index = serviceindex('Plumber');
    }
    print(index);
    final service = servicelsit[index];
    status = job.status;
    if (job.status != '') {
      status = changebutton(job.status);
    }
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 6.0,
          child: Expanded(
            flex: 3,
            // height: MediaQuery.of(context).size.height / 2,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                              isfirst: widget.showscreen != 'client' &&
                                      payStatus != 'Paid'
                                  ? true
                                  : false,
                              status: status,
                              ontap: () {
                                if (status == 'Accept') {
                                  jobProvider.updatejobstatus(
                                      job.jobId, 'pending');
                                } else if (status == 'Start') {
                                  jobProvider.updatejobstatus(
                                      job.jobId, 'started');
                                  setState(() {});
                                } else if (status == 'End') {
                                  jobProvider.updatejobstatus(
                                      job.jobId, 'completed');
                                  setState(() {});
                                }
                                // } else if (status == 'Get Payment') {
                                //   infoDialog(context,
                                //       "Total Payment is \n \n ${widget.budget.toString()}",
                                //       neutralText: 'Collect Payment',
                                //       neutralAction: () {
                                //         setState(() {
                                //           payStatus = 'Paid';
                                //         });
                                //         print(payStatus);
                                //         orderprovider.updatepaymentstatus(
                                //             widget.orderid, 'Paid');
                                //         orderprovider.updateorderstatus(
                                //             widget.orderid, 'previous');
                                //         // widget.payments == 'Due';
                                //         // orderprovider.changepaymentstatus =
                                //         //     'Paid';
                                //         Navigator.pop(context);
                                //         // Navigator.pushReplacement(
                                //         //     context,
                                //         //     MaterialPageRoute(
                                //         //         builder: (_) =>
                                //         //             Previousorders()));
                                //         // ;
                                //         print('payment collected...');
                                //       },
                                //       closeOnBackPress: true,
                                //       negativeText: 'Cancel',
                                //       negativeAction: () {
                                //         Navigator.pop(context);
                                //       },
                                //       title: 'Payment Details');
                                //   // jobProvider.updatejobstatus(
                                //   //     job.jobId, 'completed');
                                //   // setState(() {});
                                // }
                              },
                              description: ''),
                          SizedBox(
                            height: 5.0,
                          ),
                          // _profileContent(title: '#orderid', isfirst: true),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  color: Colors.grey,
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowcontent(
                        title: "Due Date:",
                        subtitle: job.postedDate,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowcontent(
                        title: "Budget:",
                        subtitle: widget.budget.toString(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowcontent(title: 'Location', subtitle: job.location),
                      // _detailrow(
                      //   title: "Location:",
                      //   description: job.location,
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowcontent(
                        title: "Sub Service:",
                        subtitle: job.detail,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowcontent(
                        title: "Pyment Status:",
                        subtitle: payStatus,
                        // subtitle: orderprovider.paymentstatus != null
                        //     ? orderprovider.paymentstatus
                        //     : widget.payments,
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30.0,
                  endIndent: 30.0,
                  color: Colors.grey,
                  height: 10.0,
                ),
                Text(
                  'Order State.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                ToggleButtonsstate(
                  state: job.status,
                  jobid: job.jobId,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowcontent({required String title, required String subtitle}) {
    return Container(
      //color: Colors.red,
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                // fontFamily: 'Avenir',
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
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
    );
  }

  Widget _profileContent(
      {required String title,
      required String description,
      required bool isfirst,
      required String status,
      required var ontap}) {
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
          width: 100.0,
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

  String changebutton(String status) {
    print('value at function...' + status);

    switch (status) {
      case 'assigned':
        status = 'Accept';

        return 'Accept';

        break;
      case 'pending':
        status = 'Start';

        return 'Start';
        break;
      case 'started':
        status = 'End';
        return 'End';
        break;
      case 'completed':
        status = 'Get Payment';
        return 'Get Payment';
        break;

      default:
        return 'Assigned';
    }
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
