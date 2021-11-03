import 'package:flutter/material.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _jobId = '';
  String _orderby = '';
  String _orderto = '';
  String _orderjobid = '';
  String _date = '';
  String _orderId = '';
  int _orderbudget = 0;
  String _paymentstatus = '';
  String _status = '';

  var uuid = const Uuid();

  //Getters
  String get jobid => _jobId;
  String get orderby => _orderby;
  String get date => _date;
  String get paymentstatus => _paymentstatus;
  String get status => _status;
  String get orderjobid => _orderjobid;

  int get orderbudget => _orderbudget;
  Stream<List<Order>> get orders => firestoreService.getorders(_orderto);
  Stream<List<Order>> get clientorders =>
      firestoreService.getclientorders(_orderby);
  Stream<List<Order>> get previousorder =>
      firestoreService.getworkerpreviousorder(_orderto);
  Stream<List<Order>> get clientpreviousorders =>
      firestoreService.getclientpreviousorders(_orderby);
  Stream<List<Order>> get singleorder =>
      firestoreService.getsingleorder(_orderjobid);

  //Setters

  // String setUseruser() {
  //   String userEmail = firestoreService.getuserEmail().toString();
  //   return userEmail;
  // }
  void updatepaymentstatus(String orderid, String status) {
    firestoreService.updatepayment(orderid, status);
  }

  void updateorderstatus(String orderid, String status) {
    firestoreService.updatestatus(orderid, status);
  }

  set changeorderjobid(String jobid) {
    _jobId = jobid;
    notifyListeners();
  }

  set changeorderby(String orderby) {
    _orderby = orderby;
    notifyListeners();
  }

  set changeorderto(String orderto) {
    _orderto = orderto;
    notifyListeners();
  }

  set changeordejobid(String orderjobid) {
    _orderjobid = orderjobid;
    notifyListeners();
  }

  set changepaymentstatus(String status) {
    _paymentstatus = status;
    notifyListeners();
  }

  set changestatus(String status) {
    _status = status;
    notifyListeners();
  }

  set changeorderdate(String date) {
    _date = date;
    notifyListeners();
  }

  set changeorderbudget(int budget) {
    _orderbudget = budget;
    notifyListeners();
  }

  //Functions
  // loadAll(JobOffers offers) {
  //   if (offers != null) {
  //     // _date = DateTime.parse(entry.date);
  //     _sender = offers.sender;
  //     _jobId = offers.jobId;
  //     _detail = offers.detail;
  //     _senderImgUrl = offers.senderImageUrl;
  //   } else {
  //     // _date = DateTime.now();
  //     _sender = null;
  //     _jobId = null;
  //     _detail = null;
  //     _senderImgUrl = null;
  //   }
  // }

  saveorders() {
    if (_orderId == '') {
      //Add
      var neworder = Order(
          orderby: _orderby,
          jobId: _jobId,
          date: _date,
          orderbudget: _orderbudget,
          paymentstatus: _paymentstatus,
          status: _status,
          orderid: uuid.v1());
      firestoreService.setorder(neworder);
    } else {
      //Edit
      var updatedorder = Order(
          orderby: _orderby,
          jobId: _jobId,
          date: _date,
          orderbudget: _orderbudget,
          paymentstatus: _paymentstatus,
          status: _status,
          orderid: uuid.v1());
      firestoreService.setorder(updatedorder);
    }
  }

  removeorder(String id) {
    firestoreService.removerorder(id);
  }
}
