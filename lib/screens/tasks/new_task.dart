import 'package:arvo/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';


class NewTaskDialog extends StatefulWidget {
  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  TextEditingController _nameController;
  DateTime taskTime;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    taskTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Create a new task",
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black, fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.017,
          ),//15
          Text(
            "Your task's name",
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black, fontSize: 15),
          ),
          ArvoTextFormField(
            controller: _nameController,
            hintText: 'At least five characters',
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.00,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Choose your event's categorie",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 15),
                ),
                FlatButton.icon(
                  splashColor: Colors.deepOrange,
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.tag_solid,
                    color: Colors.red,
                  ),
                  label: Text("Important"),
                ),
              ],
            ),
          ),
          Text(
            "Pick your task's date & time",
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black, fontSize: 15),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.010,
          // ), //10
          FlatButton(
            onPressed: () => _buildDateTimePicker(context),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 5),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.calendar_view_day,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.010,
                  ), //10
                  Text(DateFormat("EEEE dd MM yyyy").format(taskTime)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ), //50
                  Icon(
                    Icons.access_time,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.015,
                  ),
                  Text(DateFormat.Hm().format(taskTime))
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Done",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _buildDateTimePicker(BuildContext context) {
    DatePicker.showDateTimePicker(context,
        currentTime: DateTime.now(),
        showTitleActions: true,
        minTime: DateTime(DateTime.now().year, DateTime.now().month, 1),
        maxTime: DateTime(DateTime.now().year + 5, 12, 31),
        theme: DatePickerTheme(
          backgroundColor: Colors.blue,
          headerColor: Colors.orange,
          itemStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic),
        ), onConfirm: (dateTime) {
      print("On confirm date time is $dateTime");
      setState(() {
        taskTime = dateTime;
      });
      print("The task time is now $taskTime");
    });
  }
}
