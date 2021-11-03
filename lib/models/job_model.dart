import 'package:flutter/material.dart';

class Jobs {
  final String jobId;
  final String title;
  final String detail;
  final String location;
  final int budget;
  final String status;
  final String postedBy;
  final String posterImgurl;
  final String postedDate;
  final String servicetype;
  final String posterid;

  Jobs(
      {required this.title,
      required this.location,
      required this.detail,
      required this.budget,
      required this.postedBy,
      required this.posterImgurl,
      required this.postedDate,
      required this.servicetype,
      required this.posterid,
      required this.status,
      required this.jobId});

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
        title: json['title'],
        location: json['location'],
        detail: json['detail'],
        budget: json['budget'],
        postedBy: json['postedby'],
        posterImgurl: json['posterimgurl'],
        postedDate: json['posteddate'],
        servicetype: json['servicetype'],
        posterid: json['posterid'],
        status: json['status'],
        jobId: json['jobId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'detail': detail,
      'budget': budget,
      'postedby': postedBy,
      'posterimgurl': posterImgurl,
      'posteddate': postedDate,
      'status': status,
      'servicetype': servicetype,
      'posterid': posterid,
      'jobId': jobId,
    };
  }
}
