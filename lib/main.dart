import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/api/notification_api.dart';
import 'package:laundry_app/controller/job_controller.dart';
import 'package:laundry_app/controller/order_controller.dart';
import 'package:laundry_app/controller/role_controller.dart';
import 'package:laundry_app/controller/user_controller.dart';
import 'package:laundry_app/models/job_detail_model.dart';
import 'package:laundry_app/models/job_model.dart';
import 'package:laundry_app/services/authservice.dart';
import 'package:laundry_app/services/firestore_service.dart';
import 'package:laundry_app/views/corders/order_home.dart';
import 'package:laundry_app/views/on_boarding.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirestoreService firestoreService = FirestoreService();
  // late FlutterLocalNotificationsPlugin fltrNotification;
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();
    // var androidInitilize = new AndroidInitializationSettings('app_icon');
    // var iOSinitilize = new IOSInitializationSettings();
    // var initilizationsSettings =
    //      InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    // fltrNotification = new FlutterLocalNotificationsPlugin();
    // fltrNotification.initialize(initilizationsSettings,
    //     onSelectNotification: notificationSelected);
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => JobOrders(payload: payload)));

  // Future notificationSelected(String? payload) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       content: Text("Notification : $payload"),
  //     ),
  //   );
  // }
//   Future _showNotification() async {
//    var androidDetails = const AndroidNotificationDetails(
//        "Channel ID", "Code Developers",
//        importance: Importance.max);
//    var iSODetails = new IOSNotificationDetails();
//    var generalNotificationDetails =
//         NotificationDetails(android: androidDetails, iOS: iSODetails);

//     await fltrNotification.show(
//         0, "Order", "Your Order is Posted",
//         generalNotificationDetails, payload: "Task");
//  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (BuildContext context) {
            return AuthService();
          },
        ),
        StreamProvider<List<Jobs>>(
          create: (BuildContext context) => firestoreService.getsinglejob(),
          initialData: [],
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider<JobDetailProvider>(
          create: (BuildContext context) {
            return JobDetailProvider();
          },
        ),
        ChangeNotifierProvider<PostedJobProvider>(
          create: (BuildContext context) {
            return PostedJobProvider();
          },
        ),
        ChangeNotifierProvider<UserType>(
          create: (BuildContext context) {
            return UserType();
          },
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (BuildContext context) {
            return OrderProvider();
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onboarding(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), openOnBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('asset/images/bg.png'))),
        child: Center(
            child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('asset/images/logo.png'))),
        )),
      ),
    );
  }

  void openOnBoard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding()),
    );
  }
}
