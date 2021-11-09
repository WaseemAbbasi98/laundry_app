import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/models/order_model.dart';
import 'package:laundry_app/models/user.dart';
import 'package:laundry_app/services/authservice.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
AuthService _authService = AuthService();
User? currentUser = _auth.currentUser;
String? userEmail = currentUser!.email;
String uid = _auth.currentUser!.uid;
late List<String> offersenderid;

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  // final String uid;
  // String orderJobid = '';
  String jobid = '';
  String workerid = '';
  String topworkerid = '';
  String userid = '';
  // FirestoreService({required this.uid});

  Future<void> setusers(MyUser user) {
    // print('user id in firestor fun');
    // print(user.userId);
    var options = SetOptions(merge: true);

    return _db.collection('users').doc(user.userId).set(user.toMap(), options);
  }

// post job backend...
//Upsert
  Future<void> setjob(Jobs jobs) {
    var options = SetOptions(merge: true);

    return _db.collection('jobs').doc(jobs.jobId).set(jobs.toMap(), options);
  }

  void updatejobstatus(String jobid, String status) {
    _db.collection('jobs').doc(jobid).update({'status': status});
  }

  Stream<List<Jobs>> getotherjobs() {
    return _db
        .collection('jobs')
        .where('postedby', isEqualTo: currentUser!.displayName)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  }

  //get single job
  Stream<List<Jobs>> getsinglejob() {
    return _db
        .collection('jobs')
        .where('jobid', isEqualTo: 'db3d7f60-3610-11ec-9d9e-e9c312bc5361')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  }

  //User operations ....

  Stream<QuerySnapshot> getUserStream() {
    // final uid = await  _authService.getUserid();

    // print('id at db for user is' + uid);
    return _db.collection('users').where('userid', isEqualTo: uid).snapshots();
  }

  void updateuserpicturefeild(String uid, String val) {
    _db.collection('users').doc(uid).update({'picture': val});
  }
  // Stream<MyUser> get userData {
  //   return _db
  //       .collection('users')
  //       .doc(uid)
  //       .snapshots()
  //       .map(_userDataFromSnapShot);
  // }

  // MyUser _userDataFromSnapShot(DocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data();

  //   return MyUser(
  //     userId: uid,
  //     name: data['name'] ?? '',
  //     email: data['email'],
  //     mobileNo: data['mobileno'],
  //     cnic: data['cnic'],
  //     picture: data['picture'],
  //     address: data['address'],
  //     password: data['password'],
  //     type: data['type'],
  //   );
  // }

  // orders backend.........................................
  //Upsert
  Future<void> setorder(Order order) {
    var options = SetOptions(merge: true);

    return _db
        .collection('orders')
        .doc(order.orderid)
        .set(order.toMap(), options);
  }

  //Delete
  Future<void> removerorder(String id) {
    return _db.collection('orders').doc(id).delete();
  }

  Stream<List<Jobs>> getallorders() {
    return _db.collection('jobs').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  }

  Stream<List<Order>> getorders(String orderto) {
    print('order to id .....' + orderto);
    return _db
        .collection('orders')
        .where('orderto', isEqualTo: orderto)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  Stream<List<Order>> getsingleorder(String orderjobid) {
    // print('order to id .....' + jobid);
    return _db
        .collection('orders')
        .where('jobid', isEqualTo: '6d2641b0-35b1-11ec-9776-dfe134aa6501')
        // .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  Stream<List<Order>> getclientorders(String orderby) {
    print('orderby  id is.....' + orderby);
    // print();
    return _db
        .collection('orders')
        .where('orderby', isEqualTo: orderby)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  Stream<List<Order>> getworkerpreviousorder(String orderto) {
    print('order to id .....' + orderto);
    return _db
        .collection('orders')
        .where('orderto', isEqualTo: orderto)
        .where('status', isEqualTo: 'previous')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  Stream<List<Order>> getclientpreviousorders(String orderby) {
    print('orderby  id is.....' + orderby);
    // print();
    return _db
        .collection('orders')
        .where('orderby', isEqualTo: orderby)
        .where('status', isEqualTo: 'previous')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  void updatepayment(String orderid, String status) {
    _db.collection('orders').doc(orderid).update({'paymentstatus': status});
  }

  void updatestatus(String orderid, String status) {
    _db.collection('orders').doc(orderid).update({'status': status});
  }

  //Get Entries
  // Stream<List<Jobs>> getJobs() {
  //   return _db
  //       .collection('jobs')
  //       .where('postedby', isEqualTo: currentUser.displayName)
  //       //.where('jobtype', isEqualTo: 'Fixed')
  //       // .where('budget', isGreaterThan: 200)
  //       // .where('budget', isLessThan: 2500)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  // }

  // get Single job
  // Stream<List<Jobs>> getsinglejob() {
  //   return _db
  //       .collection('jobs')
  //       .where('jobid', isEqualTo: jobid)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  // }

  // Stream<List<Jobs>> getfixedjobs() {
  //   return _db
  //       .collection('jobs')
  //       .where('postedby', isEqualTo: currentUser.displayName)
  //       .where('jobtype', isEqualTo: 'Fixed')
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Jobs.fixfromJson(doc.data())).toList());
  // }

  // Stream<List<Jobs>> getallfixedjobs() {
  //   return _db
  //       .collection('jobs')
  //       .where('jobtype', isEqualTo: 'Fixed')
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Jobs.fixfromJson(doc.data())).toList());
  // }

//   Stream<List<Jobs>> getfixedjobsfilter(int start, int end) {
//     print('value at dbclass');
//     print(start);
//     print(end);
//     return _db
//         .collection('jobs')
//         // .where('budget', isGreaterThan: start)
//         // .where('budget', isLessThan: end)
//         //  .whereGreaterThanOrEqualTo("budget", start)
//         //  .whereLessThan("budget", end)
//         .where('jobtype', isEqualTo: 'Fixed')
//         .where('status', isEqualTo: 'open')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fixfromJson(doc.data())).toList());
//   }

//   Stream<List<Jobs>> getotherjobs() {
//     return _db
//         .collection('jobs')
//         .where('postedby', isEqualTo: currentUser.displayName)
//         .where('jobtype', isEqualTo: 'Other')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
//   }

//   Stream<List<Jobs>> getallotherjobs() {
//     final query = _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Other')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());

//     // print(query.first.then(value){

//     // });
//     return query;
//   }

//   Stream<List<Jobs>> getallopenotherjobs() {
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Other')
//         .where('status', isEqualTo: 'open')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
//   }

//   Stream<List<Jobs>> getallbudgetfilterotherjobs(int start, int end) {
//     print('values at db');
//     print(start);
//     print(end);
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Other')
//         .where('budget', isGreaterThanOrEqualTo: start)
//         .where('budget', isLessThanOrEqualTo: end)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());

//     // _query.forEach((element) {
//     //   print(element[0].budget);
//     // });
//   }

//   Stream<List<Jobs>> getallbudgetandstatusfilterotherjobs(int start, int end) {
//     print('values at db');
//     print(start);
//     print(end);
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Other')
//         .where('status', isEqualTo: 'open')
//         .where('budget', isGreaterThanOrEqualTo: start)
//         .where('budget', isLessThanOrEqualTo: end)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
//   }

//   Stream<List<Jobs>> otherjobsearchfilter(
//       bool statusenable, bool budgetenable, int start, int end) {
//     if (budgetenable && !statusenable) {
//       print('justbudget filtercall');
//       return getallbudgetfilterotherjobs(start, end);
//     } else if (statusenable && !budgetenable) {
//       print('juststatus filtercall');

//       return getallopenotherjobs();
//     } else if (budgetenable && statusenable) {
//       print('both filtercall');

//       return getallbudgetandstatusfilterotherjobs(start, end);
//     } else {
//       print('no filtercall');

//       return getallotherjobs();
//     }

//     // _query.forEach((element) {
//     //   print(element[0].budget);
//     // });
//   }

//   // fixed job filter.....................................
//   Stream<List<Jobs>> getallopenfixjobs() {
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Fixed')
//         .where('status', isEqualTo: 'open')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
//   }

//   Stream<List<Jobs>> getallbudgetfilterfixjobs(int start, int end) {
//     print('values at db');
//     print(start);
//     print(end);
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Fixed')
//         .where('budget', isGreaterThanOrEqualTo: start)
//         .where('budget', isLessThanOrEqualTo: end)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());

//     // _query.forEach((element) {
//     //   print(element[0].budget);
//     // });
//   }

//   Stream<List<Jobs>> getallbudgetandstatusfilterfixjobs(int start, int end) {
//     print('values at db');
//     print(start);
//     print(end);
//     return _db
//         .collection('jobs')
//         .where('jobtype', isEqualTo: 'Fixed')
//         .where('status', isEqualTo: 'open')
//         .where('budget', isGreaterThanOrEqualTo: start)
//         .where('budget', isLessThanOrEqualTo: end)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());

//     // _query.forEach((element) {
//     //   print(element[0].budget);
//     // });
//   }

//   Stream<List<Jobs>> fixjobsearchfilter(
//       bool statusenable, bool budgetenable, int start, int end) {
//     if (budgetenable && !statusenable) {
//       print('justbudget filtercall');
//       return getallbudgetfilterfixjobs(start, end);
//     } else if (statusenable && !budgetenable) {
//       print('juststatus filtercall');

//       return getallopenfixjobs();
//     } else if (budgetenable && statusenable) {
//       print('both filtercall');

//       return getallbudgetandstatusfilterfixjobs(start, end);
//     } else {
//       print('no filtercall');

//       return getallfixedjobs();
//     }
//   }

//   //Upsert
//   Future<void> setjob(Jobs jobs) {
//     var options = SetOptions(merge: true);

//     return _db.collection('jobs').doc(jobs.jobId).set(jobs.toMap(), options);
//   }

//   //set fixed job without image
//   Future<void> setfixjob(Jobs jobs) {
//     var options = SetOptions(merge: true);

//     return _db.collection('jobs').doc(jobs.jobId).set(jobs.fixtoMap(), options);
//   }

//   void updatejobstatus(String jobid, String status) {
//     _db.collection('jobs').doc(jobid).update({'status': status});
//   }

//   //Delete
//   Future<void> removejob(String jobId) {
//     return _db.collection('jobs').doc(jobId).delete();
//   }

//   sendjobMessage(JobMessage jobMessage, String jobId) {
//     // var options = SetOptions(merge: true);

//     _db
//         .collection('jobs')
//         .doc(jobId)
//         .collection('message')
//         .add(jobMessage.toMap());
//   }

//   //job offers backend
//   Stream<List<JobOffers>> getoffers(String jobid) {
//     print(jobid);
//     return _db
//         .collection('joboffers')
//         .where('jobId', isEqualTo: jobid)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobOffers.fromJson(doc.data()))
//             .toList());
//   }

//   List<String> offersenderids(String jobid) {
//     _db
//         .collection("joboffers")
//         .where('jobId', isEqualTo: jobid)
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((result) {
//         print(result.data()["name"]);
//         //  offersenderid.add(reslut)
//         print(result.data());
//       });
//     });
//   }

//   //Upsert
//   Future<void> setoffer(JobOffers offers) {
//     var options = SetOptions(merge: true);

//     return _db
//         .collection('joboffers')
//         .doc(offers.offerId)
//         .set(offers.toMap(), options);
//   }

//   //Delete
//   Future<void> removeoffer(String jobId) {
//     return _db.collection('joboffers').doc(jobId).delete();
//   }
//   // orders backend.........................................

//   Stream<List<Order>> getorders(String orderto) {
//     print('order to id .....' + orderto);
//     return _db
//         .collection('orders')
//         .where('orderto', isEqualTo: orderto)
//         .where('status', isEqualTo: 'active')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
//   }

//   Stream<List<Order>> getclientorders(String orderby) {
//     print('orderby  id is.....' + orderby);
//     // print();
//     return _db
//         .collection('orders')
//         .where('orderby', isEqualTo: orderby)
//         .where('status', isEqualTo: 'active')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
//   }

//   Stream<List<Order>> getworkerpreviousorder(String orderto) {
//     print('order to id .....' + orderto);
//     return _db
//         .collection('orders')
//         .where('orderto', isEqualTo: orderto)
//         .where('status', isEqualTo: 'previous')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
//   }

//   Stream<List<Order>> getclientpreviousorders(String orderby) {
//     print('orderby  id is.....' + orderby);
//     // print();
//     return _db
//         .collection('orders')
//         .where('orderby', isEqualTo: orderby)
//         .where('status', isEqualTo: 'previous')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
//   }

//   void updatepayment(String orderid, String status) {
//     _db.collection('orders').doc(orderid).update({'paymentstatus': status});
//   }

//   void updatestatus(String orderid, String status) {
//     _db.collection('orders').doc(orderid).update({'status': status});
//   }

// // Stream<List<Order>> getcustomerorder(String orderby) {
// //     print(orderby);
// //     return _db
// //         .collection('orders')
// //         .where('orderby', isEqualTo: orderby)
// //         .snapshots()
// //         .map((snapshot) => snapshot.docs
// //             .map((doc) => Order.fromJson(doc.data()))
// //             .toList());
// //   }
//   //Upsert
//   Future<void> setorder(Order order) {
//     var options = SetOptions(merge: true);

//     return _db
//         .collection('orders')
//         .doc(order.orderid)
//         .set(order.toMap(), options);
//   }

//   //Delete
//   Future<void> removerorder(String id) {
//     return _db.collection('joboffers').doc(id).delete();
//   }
//   //.....................User backend with firestore...................//

//   Stream<List<MyUser>> getusers() {
//     print('user id at db class is');
//     print('call at db.....');
//     return _db
//         .collection('users')
//         // .where('userid', isEqualTo: kuserid)
//         .where('type', isEqualTo: 'worker')
//         .where('rating', isGreaterThanOrEqualTo: 4)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => MyUser.fromJson(doc.data())).toList());
//   }

//   Stream<QuerySnapshot> getUserStream(String uid) {
//     // final uid = await  _authService.getUserid();
//     print('id at db for user is' + uid);
//     return _db.collection('users').where('userid', isEqualTo: uid).snapshots();
//   }

//   Stream<List<MyUser>> getuserslist() {
//     return _db
//         .collection('users')
//         .where('type', isEqualTo: 'worker')
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => MyUser.fromJson(doc.data())).toList());
//   }

//   Stream<MyUser> get userData {
//     return _db
//         .collection('users')
//         .doc(uid)
//         .snapshots()
//         .map(_userDataFromSnapShot);
//   }

//   MyUser _userDataFromSnapShot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data();

//     return MyUser(
//       userId: uid,
//       name: data['name'] ?? '',
//       email: data['email'],
//       mobileNo: data['mobileno'],
//       cnic: data['cnic'],
//       picture: data['picture'],
//       address: data['address'],
//       password: data['password'],
//     );
//   }

//   //Upsert

//   Future<void> setusers(MyUser user) {
//     // print('user id in firestor fun');
//     // print(user.userId);
//     var options = SetOptions(merge: true);

//     return _db.collection('users').doc(user.userId).set(user.toMap(), options);
//   }

//   //Delete
//   Future<void> removeuser(String userid) {
//     return _db.collection('users').doc(userid).delete();
//   }

//   Future<void> setverification(IdVerification idVerification, String userId) {
//     // var options = SetOptions(merge: true);

//     return _db
//         .collection('workers')
//         .doc(userId)
//         .collection('verification')
//         .add(idVerification.toMap());
//   }

//   Stream<List<IdVerification>> getverifications() {
//     return _db.collection('workers').snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => IdVerification.fromJson(doc.data()))
//         .toList());
//   }

//   //client backend with firestore....
//   Stream<List<Client>> getclientstream() {
//     return _db.collection('client').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => Client.fromJson(doc.data())).toList());
//   }

//   Stream<QuerySnapshot> getclient(String uid) {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('client')
//         .where('clientid', isEqualTo: uid)
//         .snapshots();
//   }

//   Stream<QuerySnapshot> getuser() {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('users')
//         .where('userid', isEqualTo: kuserid)
//         .snapshots();
//   }

//   Stream<List<Client>> getsingleclient(String uid) {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('client')
//         .where('clientid', isEqualTo: uid)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Client.fromJson(doc.data())).toList());
//   }

//   //Upsert
//   Future<void> setclient(Client client) {
//     var options = SetOptions(merge: true);

//     return _db
//         .collection('client')
//         .doc(client.clientId)
//         .set(client.toMap(), options);
//   }

//   //Delete
//   Future<void> removerclient(String clientid) {
//     return _db.collection('client').doc(clientid).delete();
//   }

//   //.........................worker backend with firestore....
//   Stream<List<Worker>> getworkers() {
//     return _db.collection('workers').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   }
//   // Stream<List<Worker>> getworkers() {
//   //   return _db.collection('workers').snapshots().map((snapshot) =>
//   //       snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   // }

//   Stream<QuerySnapshot> getWorkerStream(String uid) {
//     // final uid = await  _authService.getUserid();
//     print('id at db is....' + uid);

//     return _db
//         .collection('workers')
//         .where('workerid', isEqualTo: uid)
//         .snapshots();
//   }

//   Stream<List<Worker>> getsingleWorker(String uid) {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('workers')
//         .where('workerid', isEqualTo: uid)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   }

//   Stream<List<Worker>> gettopratedWorker() {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('workers')
//         // .where('workerid', isEqualTo: workerid)
//         .where('rating', isGreaterThanOrEqualTo: 3)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   }

//   Stream<List<Worker>> getsingleWorkerbyid() {
//     // final uid = await  _authService.getUserid();
//     return _db
//         .collection('workers')
//         .where('workerid', isEqualTo: topworkerid)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   }

//   void updateworkerfeild(String uid, bool val) {
//     _db.collection('workers').doc(uid).update({'isselected': val});
//   }

//   void updateuserpicturefeild(String uid, String val) {
//     _db.collection('users').doc(uid).update({'picture': val});
//   }

//   void updateworkergroupid(String uid, String groupid) {
//     _db.collection('workers').doc(uid).update({'groupid': groupid});
//   }

//   Stream<Worker> get workerData {
//     return _db
//         .collection('workers')
//         .doc(uid)
//         .snapshots()
//         .map(_workerDataFromSnapShot);
//   }

//   Worker _workerDataFromSnapShot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data();

//     return Worker(
//       workerId: uid,
//       totalJobs: data['totaljobs'] ?? '',
//       pendingJobs: data['pendingjobs'],
//       completeJobs: data['completedjobs'],
//       level: data['level'],
//       skill: data['skill'],
//     );
//   }

//   // Stream<List<Worker>> getsingleWorker(String workerid) {
//   //   return _db
//   //       .collection('workers')
//   //       .where(FieldPath.documentId, isEqualTo: workerid)
//   //       .limit(1)
//   //       .snapshots()
//   //       .map((snapshot) =>
//   //           snapshot.docs.map((doc) => Worker.fromJson(doc.data())).toList());
//   // }

//   // getsingelworker(String workerid) {
//   //   return _db.collection('workers').doc(workerid).get();
//   // }

//   //Upsert
//   Future<void> setworker(Worker worker) {
//     var options = SetOptions(merge: true);

//     return _db
//         .collection('workers')
//         .doc(worker.workerId)
//         .set(worker.toMap(), options);
//   }

//   Future<void> setworkers(Worker worker) {
//     var options = SetOptions(merge: true);

//     return _db
//         .collection('workers')
//         .doc(worker.workerId)
//         .set(worker.toMap(), options);
//   }

//   //Delete
//   Future<void> removeworker(String workerId) {
//     return _db.collection('workers').doc(workerId).delete();
//   }
}
