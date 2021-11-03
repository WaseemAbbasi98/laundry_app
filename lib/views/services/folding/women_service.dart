import 'package:flutter/material.dart';
import 'package:laundry_app/constants/colors.dart';
import 'package:laundry_app/models/job_detail_model.dart';
import 'package:laundry_app/viewmodels/service_detail_model.dart';
import 'package:provider/provider.dart';

class FoldingWomenServices extends StatefulWidget {
  final String type;
  const FoldingWomenServices({required this.type});

  @override
  _FoldingWomenServicesState createState() => _FoldingWomenServicesState();
}

class _FoldingWomenServicesState extends State<FoldingWomenServices> {
  List detaillist = [];
  int counter = 0;
  late JobDetailModel jobDetailModel;
  @override
  Widget build(BuildContext context) {
    int inde;
    int length = fwomen.length;
    return Expanded(
      child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),

              //padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.16,

              width: double.maxFinite,
              child: Card(
                color: Colors.white,
                elevation: 10.0,
                shadowColor: Colors.white,
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 30.0),
                  // margin: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0.0),
                  decoration: const BoxDecoration(
                      // color: Colors.red,
                      //borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 2.0, color: Colors.white)
                      ],
                      border: Border(
                          top: BorderSide(width: 2.0, color: kPrimaryColor))),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Joblist(
                          heading: fwomen[index].heading,
                          subheading: fwomen[index].subheading,
                          price: fwomen[index].price,
                          counter: fwomen[index].counter,
                          image: fwomen[index].image,
                          type: widget.type,
                          index: index,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class Joblist extends StatefulWidget {
  int total = 0;
  final String heading;
  final String subheading;
  final int price;
  final int counter;
  final int index;
  final String image;
  final String type;
  Joblist(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.counter,
      required this.image,
      required this.type,
      required this.index});

  @override
  _JoblistState createState() => _JoblistState();
}

class _JoblistState extends State<Joblist> {
  int counter = 0;

  late JobDetailModel jobDetailModel;

  @override
  Widget build(BuildContext context) {
    final itemdetailprovider =
        Provider.of<JobDetailProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              widget.image,
              height: 70,
              width: 80,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 30.0,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  widget.heading,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.subheading,
                  style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  ' ${widget.price.toString()} Rs',
                  style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.do_disturb_on_outlined),
              iconSize: 30,
              color: Colors.black,
              //hoverColor: Colors.amber,
              onPressed: () {
                setState(() {
                  if (counter != 0) {
                    counter = counter - 1;
                    print(counter);
                    if (counter == 0) {
                      itemdetailprovider.removefromlist(jobDetailModel);
                    } else {
                      try {
                        var filteredlist = itemdetailprovider.itemdetail
                            .where((item) => item.heading == widget.heading)
                            .toList();
                        filteredlist[0].counter =
                            ((filteredlist[0].counter) - 1);
                      } catch (e) {
                        print('excaptin occur ' + e.toString());
                      }
                    }
                  } else {
                    counter = 0;
                  }
                });
              },
            ),
            //),

            Text(
              '$counter',
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  fontSize: 20),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add_circle_rounded),
              iconSize: 30,
              color: Colors.black,
              //hoverColor: Colors.amber,
              onPressed: () {
                setState(() {
                  if (counter < 10) {
                    counter = counter + 1;
                    if (counter == 1) {
                      jobDetailModel = itemdetailprovider.addtolist(
                          widget.heading,
                          widget.subheading,
                          widget.price,
                          counter);
                    } else {
                      var filteredlist = itemdetailprovider.itemdetail
                          .where((item) => item.price == widget.price)
                          .toList();
                      filteredlist[0].counter = counter;
                    }
                  } else {
                    counter = counter;
                  }
                  widget.total = widget.total + (counter + 1) * widget.price;
                  print(widget.total);
                });
              },
            ),
          ],
        )
      ],
    );
  }

//   Widget _joblist(
//       {String heading,
//       String sub_heading,
//       String price,
//       int counter,
//       Function onplus(),
//       Function onmin()}) {}
}
