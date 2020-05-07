import 'package:arvo/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class NewAlarmDialog extends StatefulWidget {
  @override
  _NewAlarmDialogState createState() => _NewAlarmDialogState();
}

class _NewAlarmDialogState extends State<NewAlarmDialog> {
  DateTime _time;
  bool hasRang = false;
  bool isTapped = true;
  //TextEditingController _labelController;
  @override
  void initState() {
    //TODOimplement initState
    super.initState();
    _time = DateTime.now();
    //_labelController = TextEditingController(text: "Alarm");
  }

  @override
  Widget build(BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final db = Provider.of<AppDatabase>(context);
    print("The choosed time for alarm is $_time");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create a new Alarm",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 25),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () => db.alarmDao
                .insertAlarm(
                  AlarmsCompanion(ringTime: Value(_time)),
                )
                .whenComplete(
                  () => Navigator.pop(context),
                ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // SizedBox(
          //   height: 5,
          // ),
          Container(
            height: 250,
            color: Colors.white54,
            child: TimePickerSpinner(
              is24HourMode: is24HoursFormat,
              isForce2Digits: true,
              highlightedTextStyle: TextStyle(
                fontWeight: FontWeight.w900,
                //fontStyle: FontStyle.italic,
                fontSize: 35,
                color: Colors.deepOrange,
              ),
              normalTextStyle: TextStyle(fontSize: 25),
              spacing: 50,
              itemHeight: 50,
              onTimeChange: (time) {
                setState(() {
                  _time = time;
                });
              },
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Divider(
            height: 5,
            thickness: 5,
          ),
          ListTile(
            title: Text("Repeat"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Once"),
                Icon(CupertinoIcons.right_chevron)
              ],
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.white60,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    //SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 0),
                      child: Text(
                        "Repeat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 25),
                      ),
                    ),
                    // Divider(
                    //   height: 1,
                    //   thickness: 3,
                    // ),
                    ListTile(
                      title: Text("Sunday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Monday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Tuesday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Wednesday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Thursday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Friday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("Saturday"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 1, 12, 0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        elevation: 12,
                        splashColor: Colors.blueAccent,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 5,
          ),
          ListTile(
            title: Text("Sound"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Sound name"),
                Icon(CupertinoIcons.right_chevron)
              ],
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.white60,
                child: Text("Sound"),
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 5,
          ),
          ListTile(
            title: Text("Vibrate"),
            trailing: CupertinoSwitch(
              value: hasRang,
              onChanged: (bool value) {
                setState(() => hasRang = value);
              },
            ),
          ),
          // Divider(
          //   height: 5,
          //   thickness: 5,
          // ),
          // ListTile(
          //   title: Text("Label"),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Text("Alarm"),
          //       Icon(CupertinoIcons.right_chevron)
          //     ],
          //   ),
          //   onTap: () => showModalBottomSheet(
          //     context: context,
          //     builder: (context) => Container(
          //       color: Colors.white60,
          //       child: Wrap(
          //         alignment: WrapAlignment.center,
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(8.0,12,8.0,2),
          //             child: Text(
          //               "Label",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w900,
          //                   color: Colors.black,
          //                   fontSize: 25),
          //             ),
          //           ),
          //           ArvoTextFormField(
          //               controller: _labelController, hintText: "Alarm"),
          //           SizedBox(
          //             height: 8,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(12.0, 1, 12, 0),
          //             child: MaterialButton(
          //               shape: RoundedRectangleBorder(
          //                 side: BorderSide(color: Colors.blue, width: 3),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(10),
          //                 ),
          //               ),
          //               elevation: 12,
          //               splashColor: Colors.blueAccent,
          //               onPressed: () => Navigator.pop(context),
          //               child: Text(
          //                 "OK",
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w900,
          //                     color: Colors.black,
          //                     fontStyle: FontStyle.italic,
          //                     fontSize: 20),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Divider(
            height: 5,
            thickness: 5,
          ),
          ListTile(
            title: Text("Ring Duration"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("5 minutes"),
                Icon(CupertinoIcons.right_chevron)
              ],
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.white60,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    //SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 10),
                      child: Text(
                        "Ring duration",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 25),
                      ),
                    ),
                    ListTile(
                      title: Text("1 minute"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("5 minutes"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("10 minutes"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("15 minutes"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("20 minute"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    ListTile(
                      title: Text("30 minute"),
                      trailing: (!isTapped)
                          ? Icon(
                              CupertinoIcons.circle,
                              size: 30,
                              color: Colors.blue,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.blue,
                            ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        elevation: 12,
                        splashColor: Colors.blueAccent,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 5,
          ),
          ListTile(
            title: Text("Snooze duration"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Once"),
                Icon(CupertinoIcons.right_chevron)
              ],
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.white60,
                child: Wrap(
                  children: <Widget>[
                    Text("Snooze duration"),
                    ListTile(
                      title: Text("Something"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 5,
          ),
        ],
      ),
    );
  }
}
