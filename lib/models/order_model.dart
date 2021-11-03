class Order {
  final String orderid;
  final String jobId;
  final String orderby;
  final String date;
  final String status;
  final int orderbudget;
  final String paymentstatus;

  Order(
      {required this.jobId,
      required this.orderby,
      required this.date,
      required this.orderbudget,
      required this.paymentstatus,
      required this.status,
      required this.orderid});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        jobId: json['jobid'],
        orderby: json['orderby'],
        date: json['date'],
        orderbudget: json['orderbudget'],
        paymentstatus: json['paymentstatus'],
        status: json['status'],
        orderid: json['orderid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'jobid': jobId,
      'orderby': orderby,
      'date': date,
      'status': status,
      'orderbudget': orderbudget,
      'paymentstatus': paymentstatus,
      'orderid': orderid,
    };
  }
}
