import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'screens/home.dart';
import 'service/database.dart';

AppDatabase _database;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}

void main() {
  _database = AppDatabase();
  runApp(
    ChangeNotifierProvider<AppDatabase>(
      child: MyApp(),
      create: (BuildContext context) => _database, //AppDatabase()
    ),
  );
}
// void main() {
//   runApp(
//     Provider<AppDatabase>(
//       child: MyApp(),
//       create: (BuildContext context) => AppDatabase(),
//       dispose: (context,db) => db.close(),
//     ),
//   );
// }

//final database = AppDatabase();
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Afterglow',
          primarySwatch: Colors.lightBlue,
        ),
        home: MyHomePage(),
      ),
      providers: [
        Provider(create: (_) => _database.alarmDao),
        Provider(create: (_) => _database.eventDao),
        Provider(create: (_) => _database.projectDao),
        Provider(create: (_) => _database.subTaskDao),
        Provider(create: (_) => _database.tagDao),
        Provider(create: (_) => _database.taskDao),
      ],
    );
  }
}
