import 'package:flutter/material.dart';

class JobDetailModel {
  String heading;
  String subheading;
  int price;
  int counter;
  JobDetailModel(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.counter});
}

// List<JobDetailModel> itemdetail = [];

class JobDetailProvider with ChangeNotifier {
  List<JobDetailModel> itemdetail = [];
  JobDetailModel addtolist(
      String heading, String subheading, int price, int counter) {
    JobDetailModel jd = JobDetailModel(
        heading: heading,
        subheading: subheading,
        price: price,
        counter: counter);
    itemdetail.add(jd);

    notifyListeners();
    return jd;
  }

  List<JobDetailModel> getitemdetail() {
    return itemdetail;
  }

  void removefromlist(JobDetailModel model) {
    itemdetail.remove(model);
    notifyListeners();
    print('model of list');
    print(model.toString());
  }
}
