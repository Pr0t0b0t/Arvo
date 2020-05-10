import 'package:arvo/service/database.dart';
import 'package:arvo/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class NewEventDialog extends StatefulWidget {
  @override
  _NewEventDialogState createState() => _NewEventDialogState();
}

class _NewEventDialogState extends State<NewEventDialog> {
  TextEditingController _descriptionController;
  TextEditingController _nameController;
  DateTime startTime, endTime;
  AsyncSnapshot data;
  static const DEFAULT_COLOR = Colors.green;
  Color pickedTagColor = DEFAULT_COLOR;
  var _formKey;
  Tag _choosedTag;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    startTime = DateTime.now();
    endTime = DateTime.now();
    _choosedTag = Tag(id: 1, name: "Standard", color: 4283215696);
  }

  @override
  Widget build(BuildContext context) {
   setState(() {
     endTime = startTime;
   });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
              ), //15
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
              ), //15
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
              Consumer<List<Tag>>(
                builder: (BuildContext context, value, Widget child) {
                  final tags = value ?? List();
                  return Card(
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
                          /**<DropdownMenuItem<Tag>> */
                          DropdownButton<Tag>(
                            value: _choosedTag,
                            isExpanded: false,
                            hint: Text("Choose a tag"),
                            onChanged: (value) {
                              setState(() {
                                _choosedTag = value;
                              });
                            },
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900),
                            selectedItemBuilder: (context) => tags
                                .map<Widget>(
                                  (Tag tag) => Row(
                                    children: <Widget>[
                                      Icon(
                                        CupertinoIcons.tag_solid,
                                        color: Color(tag.color),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                      ),
                                      Text(tag.name)
                                    ],
                                  ),
                                )
                                .toList(),
                            items: tags
                                .map(
                                  (Tag tag) => DropdownMenuItem<Tag>(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          CupertinoIcons.tag_solid,
                                          color: Color(
                                              tag.color), //Colors.black87,
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025,
                                        ),
                                        Text(tag.name)
                                      ],
                                    ),
                                    value: tag,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              ), //10
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
                      ), //10
                      Text(
                        DateFormat("EEEE dd MM yyyy").format(startTime),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
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
              ), //10
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
                        width: MediaQuery.of(context).size.width * 0.08,
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
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          final db =
                              Provider.of<AppDatabase>(context, listen: false);
                          final ev = EventsCompanion(
                              evName: Value(_nameController.text),
                              description: Value(_descriptionController.text),
                              endDate: Value(endTime),
                              startDate: Value(startTime),
                              tag: Value(_choosedTag.id));
                          var result = db.eventDao
                              .insertEvent(ev)
                              .whenComplete(() => _resetEverythings());
                          (result != null)
                              ? print(
                                  "Event ${ev.evName.value} scheduled successfully")
                              : print("Failed to save the new event");
                        }
                      });
                    },
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
        currentTime: startTime,
        showTitleActions: true,
        minTime: DateTime(startTime.year, startTime.month, startTime.day,startTime.hour,startTime.minute),
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

  _resetEverythings() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
    });
    print("Tag id is ${_choosedTag.id}");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }
}
