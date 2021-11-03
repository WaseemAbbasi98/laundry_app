import 'package:flutter/material.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class PostedJobProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _jobId = '';
  String _title = '';
  String _detail = '';
  String _location = '';

  String _imageUrl = '';
  String _status = '';
  int _budget = 0;
  String _postedBy = '';
  String _posterImgurl = '';
  String _postedDate = '';
  String _serviceType = '';

  String _posterid = '';
  //discussion variables....

  var uuid = Uuid();
// search filters....
  int _startbudget = 0;
  int _endbudget = 0;
  bool isbudgetenable = false;
  bool isstatusenable = false;
  //Getters
  String get jobid => _jobId;
  String get jobtitle => _title;
  String get jobdetail => _detail;
  String get joblocation => _location;
  int get jobbudget => _budget;
  String get jobimgurl => _imageUrl;
  String get jobstatus => _status;
  String get jobpostedby => _postedBy;
  String get jobposterimgurl => _posterImgurl;
  String get jobposteddate => _postedDate;
  String get servicetype => _serviceType;

  String get jobposterid => _posterid;

  //search filter getter..
  int get startbudgt => _startbudget;
  int get endbudgt => _endbudget;
  bool get budgetenable => isbudgetenable;
  bool get statusfilter => isstatusenable;

  // Stream<List<Jobs>> get jobs => firestoreService.getJobs();
  // Stream<List<Jobs>> get singeljob => firestoreService.getsinglejob(_jobId);

  // Stream<List<Jobs>> get allfixedjobs => firestoreService.getallfixedjobs();
  // Stream<List<Jobs>> get allotherjobs => firestoreService.getallotherjobs();
  // Stream<List<Jobs>> get fixedjobs => firestoreService.getfixedjobs();
  // //filtered jobs streams.................
  // Stream<List<Jobs>> get othefilterjobs =>
  //     firestoreService.otherjobsearchfilter(
  //         isstatusenable, isbudgetenable, _startbudget, _endbudget);
  // Stream<List<Jobs>> get fixfilterjobs => firestoreService.fixjobsearchfilter(
  //     isstatusenable, isbudgetenable, _startbudget, _endbudget);
  // Stream<List<Jobs>> get budgetfixedjobs =>
  //     firestoreService.getallbudgetfilterotherjobs(_startbudget, _endbudget);
  // Stream<List<Jobs>> get budgetfixedotherjobs =>
  //     firestoreService.getallbudgetfilterotherjobs(_startbudget, _endbudget);
  // Stream<List<Jobs>> get openotherjobs =>
  //     firestoreService.getallopenotherjobs();
  Stream<List<Jobs>> get otherjobs => firestoreService.getotherjobs();
  Stream<List<Jobs>> get allorders => firestoreService.getallorders();

  //Setters
  set changeDate(String date) {
    _postedDate = date;
    notifyListeners();
  }

  set changejobid(String jobid) {
    _jobId = jobid;
    notifyListeners();
  }

  set changetitle(String title) {
    _title = title;
    notifyListeners();
  }

  set changedetail(String detial) {
    _detail = detial;
    notifyListeners();
  }

  set changeloction(String location) {
    _location = location;
    notifyListeners();
  }

  set changebudget(int budget) {
    _budget = budget;
    notifyListeners();
  }

  set changeimageurl(String imgurl) {
    _imageUrl = imgurl;
    notifyListeners();
  }

  set changestatus(String status) {
    _status = status;
    notifyListeners();
  }

  set changepostedby(String poster) {
    _postedBy = poster;
    notifyListeners();
  }

  set changeposterUrl(String imgurl) {
    _posterImgurl = imgurl;
    notifyListeners();
  }

  set changeservicetype(String stype) {
    _serviceType = stype;
    notifyListeners();
  }

  set changejobsenderid(String posterid) {
    _posterid = posterid;
    notifyListeners();
  }

// discession setters.......

  //getter jobfilter fields...
  set changestartbudget(int start) {
    _startbudget = start;
    notifyListeners();
  }

  set changeendbudget(int end) {
    _endbudget = end;
    notifyListeners();
  }

  set changebudgetenable(bool enable) {
    isbudgetenable = enable;
    notifyListeners();
  }

  set changestatusenable(bool enable) {
    isstatusenable = enable;
    notifyListeners();
  }

  //Functions

  savejobs() {
    if (_jobId == '') {
      //Add
      var newjob = Jobs(
          title: _title,
          location: _location,
          budget: _budget,
          detail: _detail,
          status: _status,
          postedBy: _postedBy,
          posterImgurl: _posterImgurl,
          postedDate: _postedDate.toString(),
          servicetype: _serviceType,
          posterid: _posterid,
          jobId: uuid.v1());
      print(newjob.title);
      firestoreService.setjob(newjob);
    } else {
      //Edit
      var updtedjob = Jobs(
          title: _title,
          location: _location,
          budget: _budget,
          status: _status,
          detail: _detail,
          postedBy: _postedBy,
          posterImgurl: _posterImgurl,
          postedDate: _postedDate,
          servicetype: _serviceType,
          posterid: _posterid,
          jobId: uuid.v1());

      firestoreService.setjob(updtedjob);
    }
  }

  // savefixjobs() {
  //   if (_jobId == null) {
  //     //Add
  //     var newjob = Jobs(
  //         title: _title,
  //         location: _location,
  //         budget: _budget,
  //         offers: _offers,
  //         status: _status,
  //         detail: _detail,
  //         postedBy: _postedBy,
  //         posterImgurl: _posterImgurl,
  //         postedDate: _postedDate.toString(),
  //         servicetype: _serviceType,
  //         jobtype: _jobType,
  //         posterid: _posterid,
  //         jobId: uuid.v1());
  //     print(newjob.title);
  //     firestoreService.setfixjob(newjob);
  //   } else {
  //     //Edit
  //     var updtedjob = Jobs(
  //         title: _title,
  //         location: _location,
  //         budget: _budget,
  //         offers: _offers,
  //         status: _status,
  //         detail: _detail,
  //         postedBy: _postedBy,
  //         posterImgurl: _posterImgurl,
  //         postedDate: _postedDate,
  //         servicetype: _serviceType,
  //         posterid: _posterid,
  //         jobtype: _jobType,
  //         jobId: uuid.v1());

  //     firestoreService.setfixjob(updtedjob);
  //   }
  // }

  // removejob(String jobId) {
  //   firestoreService.removejob(jobId);
  // }

  updatejobstatus(String jobid, String status) {
    if (jobid != null) {
      firestoreService.updatejobstatus(jobid, status);
    }
  }
}
