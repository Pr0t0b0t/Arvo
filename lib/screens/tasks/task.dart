import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDone = false;
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
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Card(
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
                              height: 72,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(8),
                                //   bottomLeft: Radius.circular(8)
                                // ),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                value: isDone,
                                groupValue: null,
                                onChanged: null,
                                title: Text("Title"),
                                subtitle: Text("Subtitle"),
                                selected: true,
                                secondary: Text("data"),
                              ),
                            ),
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: 50),
            )
          ],
        ),
      ),
    );
  }
}
