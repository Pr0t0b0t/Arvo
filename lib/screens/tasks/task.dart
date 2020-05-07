import 'package:arvo/service/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    
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
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      height: 52,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: Color(task.tag.color),
                                        // borderRadius: BorderRadius.only(
                                        //   topLeft: Radius.circular(8),
                                        //   bottomLeft: Radius.circular(8)
                                        // ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        value: task.task.isCompleted,
                                        groupValue: null,
                                        onChanged: (value) =>
                                            db.taskDao.updateTask(
                                          task.task
                                              .copyWith(isCompleted: value),
                                        ),
                                        title: Text(task.task.name),
                                        subtitle: Text(task.tag.name),
                                        selected: true,
                                        secondary: Column(
                                          children: <Widget>[
                                            Text(
                                              DateFormat.Hms()
                                                  .format(task.task.dueDate),
                                            ),
                                            Text(
                                              DateFormat("dd MM yyyy")
                                                  .format(task.task.dueDate),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: 50),
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
      child: Column(
        children: <Widget>[
          Text(
            "There is no scheduled task for now",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
