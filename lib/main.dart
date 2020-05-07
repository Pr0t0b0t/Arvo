import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'service/database.dart';

AppDatabase _database;
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
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
      providers: [
        Provider(create: (_) => _database.eventDao),
        Provider(create: (_) => _database.projectDao),
        Provider(create: (_) => _database.subTaskDao),
        Provider(create: (_) => _database.tagDao),
        Provider(create: (_) => _database.taskDao),
      ],
    );
  }
}
