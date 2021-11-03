import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/views/corders/posted_order_details.dart';
import 'package:provider/provider.dart';

late User _loginUser;
late String name;

class JobOrders extends StatefulWidget {
  final String? payload;
  const JobOrders({this.payload});

  @override
  _JobOrdersState createState() => _JobOrdersState();
}

class _JobOrdersState extends State<JobOrders> {
  @override
  void initState() {
    _loginUser = FirebaseAuth.instance.currentUser!;
    name = _loginUser.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<PostedJobProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Posted Orders'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                _top(),
                //
              ],
            ),
            //
            const SizedBox(height: 20.0),

            const SizedBox(height: 10.0),
            StreamBuilder<List<Jobs>>(
              //  _firestore
              //     .collection('posted_projects')
              //     .where("posted_by", isEqualTo: email)
              //     .snapshots(),
              stream: jobProvider.otherjobs,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print(snapshot.error.toString());
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepOrange,
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Order Posted Yet...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // final postedJobs = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 6.0,
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(10.0),
                                leading: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('asset/images/user.png')),
                                title: Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(snapshot.data![index].location),
                                trailing: RaisedButton(
                                  color: kPrimaryColor,
                                  child: const Text('View Detail',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    print(snapshot.data![index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PostedJobDetail(
                                                  jobs: snapshot.data![index],
                                                )));
                                  },
                                )),
                          ),
                        );
                        // return _buildListCard(pjobs: postedJobs);
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _top() {
    void _showBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //height: 1000,
              color: Colors.brown[50],
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric(
                horizontal: 60.0,
                vertical: 20.0,
              ),
              // child: SearchFilter(),
            );
          });
    }

    return Container(
      height: 70,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      // child: Column(
      //   children: [
      //     SizedBox(
      //       height: 30.0,
      //     ),
      //     Container(
      //       child: Card(
      //         elevation: 4,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //         //margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             border: InputBorder.none,
      //             hintText: "Search",
      //             fillColor: Colors.white,
      //             //enabled: true,
      //             //filled: true,
      //             prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
      //             suffixIcon: InkWell(
      //               child: Icon(Icons.filter_list, color: Colors.deepOrange),
      //               onTap: () {
      //                 // keybo

      //                 _showBottomSheet();
      //               },
      //             ),
      //             //suffixIcon: Icon(Icons.filter_list),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
