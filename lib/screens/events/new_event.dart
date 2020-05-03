import 'package:arvo/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';


class NewEventDialog extends StatefulWidget {
  @override
  _NewEventDialogState createState() => _NewEventDialogState();
}

class _NewEventDialogState extends State<NewEventDialog> {
  TextEditingController _descriptionController;
  TextEditingController _nameController;
  DateTime startTime, endTime;
  static const DEFAULT_COLOR = Colors.green;
  Color pickedTagColor = DEFAULT_COLOR;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _nameController = TextEditingController();
    startTime = DateTime.now();
    endTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Create a new event",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 25),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),//15
            Text(
              "Your event's name",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 15),
            ),
            ArvoTextFormField(
              controller: _nameController,
              hintText: 'At least five characters',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),//15
            Text(
              "Your event's description",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 15),
            ),
            ArvoTextFormField(
              controller: _descriptionController,
              hintText: 'At least five characters ',
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 15),
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
                      onPressed: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          content: MaterialColorPicker(
                            selectedColor: DEFAULT_COLOR,
                            onMainColorChange: (colorSwatch) {
                              setState(() => pickedTagColor = colorSwatch);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.tag_solid,
                        color: pickedTagColor,
                      ),
                      label: Text("Important"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.010,
            ),//10
            Text(
              "Pick your event's date & time start",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 15),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            FlatButton(
              onPressed: () => _buildStartDateTimePicker(context),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 5),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_view_day,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.010,
                    ),//10
                    Text(
                      DateFormat("EEEE dd MM yyyy").format(startTime),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.010,
                    ),
                    Text(DateFormat.Hm().format(startTime))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.010,
            ),//10
            Text(
              "Pick your event's date & time end",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 15),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            FlatButton(
              onPressed: () => _buildEndDateTimePicker(context),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 5),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_view_day,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.010,
                    ),
                    Text(
                      DateFormat("EEEE dd MM yyyy").format(endTime),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.020,
                    ), //10
                    Text(DateFormat.Hm().format(endTime))
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
                        color: Colors.blue,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _buildStartDateTimePicker(BuildContext context) {
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
        startTime = dateTime;
      });
      print("The event's start time is now $startTime");
    });
  }

  void _buildEndDateTimePicker(BuildContext context) {
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
        endTime = dateTime;
      });
      print("The event's end time is now $endTime");
    });
  }
}
