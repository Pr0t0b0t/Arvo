import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool _shower, isActive;
  @override
  void initState() {
    super.initState();
    _shower = false;
    isActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red[300],
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Created Projects",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,)
                  //fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(15),
                //   bottomLeft: Radius.circular(15),
                // ),
                color: Colors.amber,
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 20, top: 8),
                      child: InkWell(
                        onDoubleTap: () {
                          setState(() {
                            _shower = false;
                          });
                        },
                        onLongPress: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Delete Project",
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "Sure that you wanna to delete this project.?",
                              textAlign: TextAlign.center,
                            ),
                            //backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  return Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.red,
                                      fontSize: 20),
                                ),
                                elevation: 5,
                                // color: Colors.red,
                                // shape: RoundedRectangleBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20)),
                                // ),
                              ),
                              SizedBox(width: 90),
                              MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                      fontSize: 20),
                                ),
                                elevation: 15,
                                // color: Colors.blue,
                                // shape: RoundedRectangleBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(20)),
                                // ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _shower = true;
                          });
                        },
                        child: Card(
                          color: Colors.grey,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 18, top: 15),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(width: 1),
                                        Text(
                                          "Project Name",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                              //fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(width: 1),
                                        Text(
                                          "Project Subname",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,)
                                              //fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(width: 10),
                                        Text(
                                          "Project Date & Time",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,)
                                              //fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "Project Completed",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                          //fontStyle: FontStyle.italic),
                                    ),
                                    //SizedBox(height: 15)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  itemCount: 10),
            ),
            SizedBox(height: 15),
            Text(
              "Project {project name} tasks",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
                  //fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 15),
            Expanded(
              child: (_shower)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            elevation: 10,
                            //margin: EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 72,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CheckboxListTile(
                                    value: isActive,
                                    title: Text("Title"),
                                    secondary: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Container(
                                        //   width: 5,
                                        //   color: Colors.green,
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        Column(
                                          children: <Widget>[
                                            SizedBox(height: 12),
                                            Text("Time"),
                                            SizedBox(height: 5),
                                            Text("Date")
                                          ],
                                        ),
                                      ],
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        isActive = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 5),
                      itemCount: 20)
                  : Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "1-One Tap on a project tile to display his details..!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19,
                                ),
                                //fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "2-Double Tap on a project tile to hide them..!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19,
                                ),
                                //fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "3-Long Press on a project tile to delete..!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19,
                                ),
                                //fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "4-Slide to left on a task tile to delete..!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19,)
                                //fontWeight: FontWeight.w900),
                                //fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "COMING SOON IN NEXT RELEASE :) ..!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w900,)
                                //fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
