import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/api/notification_api.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/models/job_detail_model.dart';
import 'package:laundry_app/views/corders/order_home.dart';
import 'package:laundry_app/views/services/component/maplocation.dart';
import 'package:laundry_app/widgets/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

final _auth = FirebaseAuth.instance;

int total = 0;
int subTotal = 0;
String jobtitle = 'Need Laundry services';
String jobDetail = '';
String? postername = '';
String? posterid = '';

class Jobdetail extends StatefulWidget {
  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  final String serviceType;
  // ignore: use_key_in_widget_constructors
  const Jobdetail({required this.serviceType});

  @override
  _JobdetailState createState() => _JobdetailState();
}

class _JobdetailState extends State<Jobdetail> {
  late PickResult selectedPlace;
  String apikey = "AIzaSyC3-f5jxNExPRAmeg1rj7sLVGN3tWzjwjI";

  @override
  void initState() {
    postername = _auth.currentUser!.displayName;
    posterid = _auth.currentUser!.uid;
    //  final provider = Provider.of<JobDetailProvider>(context, listen: false);
    // final jobprovider = Provider.of<PostedJobProvider>(context, listen: false);
    total = calculateTotal();
    setDetail();
    // print(provider.getitemdetail().length);
    super.initState();
  }

  int calculateTotal() {
    final itemdetailprovider =
        Provider.of<JobDetailProvider>(context, listen: false);
    int length = itemdetailprovider.getitemdetail().length;
    int serviceCharges = 99;
    int subtotal = 0;
    for (int i = 0; i < length; i++) {
      subtotal = subtotal +
          (itemdetailprovider.itemdetail[i].price) *
              (itemdetailprovider.itemdetail[i].counter);
    }
    print(subtotal + serviceCharges);
    setState(() {
      subTotal = subtotal;
      total = subtotal + serviceCharges;
    });
    return total;
  }

  void setDetail() {
    final itemdetailprovider =
        Provider.of<JobDetailProvider>(context, listen: false);
    int length = itemdetailprovider.getitemdetail().length;
    String jobdetail = " ";
    for (int i = 0; i < length; i++) {
      jobdetail = jobdetail +
          " " +
          (itemdetailprovider.itemdetail[i].heading +
              "  x" +
              itemdetailprovider.itemdetail[i].counter.toString() +
              " " +
              itemdetailprovider.itemdetail[i].subheading +
              "\n");
    }

    setState(() {
      jobDetail = jobdetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobprovider = Provider.of<PostedJobProvider>(context, listen: false);
    final orderprovider = Provider.of<OrderProvider>(context, listen: false);

    final itemdetailprovider =
        Provider.of<JobDetailProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change  color here
        ),
        backgroundColor: kPrimaryColor,
        bottomOpacity: 0.5,
        title: const Text(
          'Service Details',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            //color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _topCardWidget(),
          const SizedBox(height: 5.0),
          Card(
            elevation: 5.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Item name'),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Item price'),
                      Text('Item quantity'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
          _centerCardWidget(),
          // SizedBox(
          //   height: 10.0,
          // ),
          _cardWidget(),
          // SizedBox(
          //   height: 10.0,
          // ),
          // _bottom(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
                btnText: 'Order Now',
                onClick: () {
                  jobprovider.changetitle = jobtitle;
                  jobprovider.changebudget = total;
                  jobprovider.changedetail = jobDetail;
                  jobprovider.changejobsenderid = posterid!;
                  jobprovider.changepostedby = postername!;
                  jobprovider.changeservicetype = widget.serviceType;
                  var value = DateTime.now();
                  var formattedDate =
                      "${value.day}-${value.month}-${value.year}";
                  jobprovider.changeDate = formattedDate.toString();
                  //save order ...
                  orderprovider.changeorderby = postername!;
                  orderprovider.changepaymentstatus = 'Due';
                  orderprovider.changestatus = 'active';
                  orderprovider.changeorderbudget = total;
                  orderprovider.changeorderdate = formattedDate.toString();
                  orderprovider.saveorders();
                  jobprovider.savejobs();
                  itemdetailprovider.itemdetail.clear();
                  NotificationApi.showNotification(
                      title: 'Order Notification',
                      body: 'Order Save Successfully',
                      payload: 'payload');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const JobOrders()));
                }
                // },
                ),
          ),
        ],
      ),
    );
  }

  Widget _topCardWidget() {
    final jobprovider = Provider.of<PostedJobProvider>(context, listen: false);

    return Card(
      elevation: 6.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JOB LOCATION',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Divider(
              color: Colors.grey[900],
            ),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 50.0,
              children: [
                jobprovider.joblocation == ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            jobprovider.joblocation != ''
                                ? jobprovider.joblocation
                                : 'Chose Job Location',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            color: kPrimaryColor,
                            icon: const Icon(Icons.forward),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PlacePicker(
                                    apiKey: apikey,
                                    initialPosition:
                                        MapLocation.kInitialPosition,
                                    useCurrentLocation: true,
                                    selectInitialPosition: true,
                                    usePlaceDetailSearch: true,
                                    onPlacePicked: (result) {
                                      selectedPlace = result;

                                      Navigator.of(context).pop();
                                      setState(() {
                                        jobprovider.changeloction =
                                            selectedPlace.formattedAddress!;
                                      });
                                    },
                                  );
                                },
                              ));
                            },
                          )
                        ],
                      )
                    : Text(
                        jobprovider.joblocation != ''
                            ? jobprovider.joblocation
                            : 'Chose Job Location',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
            // Row(
            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Pick Job Validity Date',
            //       style: TextStyle(
            //         fontSize: 16.0,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 12.0,
            //     ),
            //     IconButton(
            //         icon: Icon(
            //           Icons.calendar_today,
            //           color: Colors.deepOrange,
            //           size: 20.0,
            //         ),
            //         onPressed: () {
            //           _pickDate(context, jobprovider).then((value) {
            //             if (value != null) {
            //               // DateFormat('MM/dd/yyyy').format(value);
            //               setState(() {
            //                 var formattedDate =
            //                     "${value.day}-${value.month}-${value.year}";
            //                 jobprovider.changeDate = formattedDate;
            //               });
            //             }
            //           });
            //         }),
            //     jobprovider.jobposteddate != null
            //         ? Text(
            //             jobprovider.jobposteddate,
            //             //  jobprovider.jobpostedate,
            //             // DateFormat('MM/dd/yyyy')
            //             //     .format(jobprovider.jobposteddate),
            //             style:
            //                 TextStyle(fontSize: 18.0, color: Colors.blueGrey),
            //           )
            //         : Text(
            //             formatDate(DateTime.now(), [MM, ' ', d, ', ', yyyy]),
            //             style:
            //                 TextStyle(fontSize: 16.0, color: Colors.blueGrey),
            //           ),
          ],
        ),
      ),
    );
  }

  Widget _centerCardWidget() {
    final itemdetailprovider =
        Provider.of<JobDetailProvider>(context, listen: false);
    int length = itemdetailprovider.getitemdetail().length;
    return Expanded(
      // flex: 5,
      child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                length > 0
                                    ? Text(itemdetailprovider
                                        .getitemdetail()[index]
                                        .heading)
                                    : Text('no item yet'),

                                // Text(itemdetailprovider.getitemdetail()[index].subheading),
                                Text(itemdetailprovider
                                    .getitemdetail()[index]
                                    .price
                                    .toString()),

                                Text(itemdetailprovider
                                    .getitemdetail()[index]
                                    .counter
                                    .toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      'No Item Added Yet',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                    ),
                  );
          }),
    );
    // return Card(
    //   elevation: 6.0,
    //   child: Container(
    //     padding: EdgeInsets.all(15.0),
    //     color: Colors.white,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text('ITEMS',
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: Colors.black54,
    //               fontWeight: FontWeight.bold,
    //             )),
    //         SizedBox(
    //           height: 2.0,
    //         ),
    //         Divider(
    //           color: Colors.grey[900],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text('Item detail',
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   color: Colors.black,
    //                 )),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   'Quantity',
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 20.0,
    //                 ),
    //                 Text(
    //                   'Price',
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _cardWidget() {
    Color dcolor = Colors.grey;
    return Card(
      elevation: 6.0,
      child: Container(
        padding: EdgeInsets.all(15.0),
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JOB TOTAL',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: dcolor,
            ),
            _rowWidget(
              title: 'Service Charges',
              price: 'Rs. 99',
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: dcolor,
            ),
            _rowWidget(
              title: 'Sub Total',
              price: 'Rs. $subTotal',
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: dcolor,
            ),
            _rowWidget(
              title: 'Total',
              price: 'Rs. $total',
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              color: dcolor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowWidget({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Widget _bottom() {
  //   return Container(
  //     color: Colors.white,
  //     height: 80,
  //     // padding: EdgeInsets.symmetric(horizontal: 10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         SmallButton(
  //           btnText: 'Post Now',
  //           onClick: () {
  //             Navigator.push(
  //                 context, MaterialPageRoute(builder: (_) => MyOrders()));
  //           },
  //         ),
  //         SmallButton(
  //           btnText: 'Schedule',
  //           onClick: () {
  //             setDetail();
  //             //   DateTime selectedDate = DateTime.now();

  //             //   //final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  //             //   showDateTimeDialog(context, initialDate: selectedDate,
  //             //       onSelectedDate: (selectedDate) {
  //             //     setState(() {
  //             //       selectedDate = selectedDate;
  //             //     });
  //             //   });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  //}

  // Future<DateTime> _pickDate(
  //     BuildContext context, PostedJobProvider jobProvider) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2019),
  //       lastDate: DateTime(2050));

  //   if (picked != null) return picked;
  // }

  //
}
