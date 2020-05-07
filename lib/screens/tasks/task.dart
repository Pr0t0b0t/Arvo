import 'package:arvo/service/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TimeOfDay timeOfDay ;
  
  @override
  Widget build(BuildContext context) {
    // timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    // String res = timeOfDay.format(context);
    // bool is12HoursFormat = res.contains(new RegExp(r'[A-Z]'));
    // print(is12HoursFormat);
    
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    print("24hours format is $is24HoursFormat");
    final db = Provider.of<AppDatabase>(context);
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "All Created Tasks",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 35,
                    color: Colors.white),
              ),
            ),
            Consumer<List<TaskWithTag>>(
              builder: (BuildContext context, value, Widget child) {
                final tasks = value ?? List();
                return (tasks.isEmpty)
                    ? _buildCenterEmptyTaskMethod()
                    : Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18.0, 12, 18, 0),
                                child: Card(
                                  elevation: 20,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 52,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: Color(task.tag.color),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: RadioListTile(
                                          value: task.task.isCompleted,
                                          groupValue: null,
                                          onChanged: (value) =>
                                              db.taskDao.updateTask(
                                            task.task
                                                .copyWith(isCompleted: value),
                                          ),
                                          title: Text(
                                            task.task.name,
                                            style: TextStyle(
                                                //fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          subtitle: Text(task.tag.name),
                                          selected: true,
                                          secondary: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.015,
                                              ),
                                              (is24HoursFormat)?Text(
                                                DateFormat.Hm()
                                                    .format(task.task.dueDate),
                                              ):Text(
                                                DateFormat.jm()
                                                    .format(task.task.dueDate),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Text(
                                                DateFormat("EEEE dd MM")
                                                    .format(task.task.dueDate),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: tasks.length),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  Center _buildCenterEmptyTaskMethod() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Text(
          "There is no scheduled task for now",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
