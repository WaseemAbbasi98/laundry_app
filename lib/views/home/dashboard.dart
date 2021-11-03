import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/constants/constantsvaribale.dart';
import 'package:laundry_app/constants/style.dart';
import 'package:laundry_app/viewmodels/service_detail_model.dart';
import 'package:laundry_app/viewmodels/service_model.dart';
import 'package:laundry_app/views/home/drawer.dart';
import 'package:laundry_app/views/services/dryclean/dry_clean_state.dart';
import 'package:laundry_app/views/services/folding/folding_state.dart';
import 'package:laundry_app/views/services/ironing/dry_clean_state.dart';
import 'package:laundry_app/views/services/services.dart';

import 'components/top_container.dart';

class HomeDashboard extends StatefulWidget {
  HomeDashboard({Key? key, required this.useremail}) : super(key: key);
  final String? useremail;
  //double _rating = 4.0;

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(apptitle),
            centerTitle: true,
          ),
          drawer: MainDrawer(
              // showscreen: 'client',
              ),
          body: ListView(
            children: <Widget>[
              const TopContainer(),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Our Services",
                      style: kHeadingTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 320.0,
                // color: Colors.grey,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: servicelsit.length,
                  itemBuilder: (context, index) {
                    int ind = index;
                    final service = servicelsit[index];

                    return _gridItem(
                        service: service,
                        ontap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: (context) => WorkerCard()));
                                      builder: (context) => Jobsstate(
                                            sType: 'Wash',
                                          )));
                              break;
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: (context) => WorkerCard()));
                                      builder: (context) => IroningJobsstate(
                                            sType: 'Iron',
                                          )));
                              break;
                            case 2:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: (context) => WorkerCard()));
                                      builder: (context) => DryCleanJobsstate(
                                            sType: 'DryClean',
                                          )));
                              break;
                            case 3:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      // builder: (context) => WorkerCard()));
                                      builder: (context) => FoldingJobsstate(
                                            sType: 'Folding',
                                          )));
                          }
                        });
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )),
    );
  }

  _gridItem({required Services service, var ontap}) {
    //flex :3
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 6.0,
        // color: Colors.grey[200],
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Image.asset(
              service.img,
              fit: BoxFit.fill,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              service.title,
              style: kheadingTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
