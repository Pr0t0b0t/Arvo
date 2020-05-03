import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.teal,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
              ),
              elevation: 20,
              expandedHeight: 300,
              centerTitle: true,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Ring in hh hours mm min..!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                background: null,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Column(
                        children: <Widget>[
                          SizedBox(height: 15),
                          InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              elevation: 15,
                              child: Slidable(
                                child: ListTile(
                                  title: Text("Alarm $index "),
                                  subtitle: Text("Event's description"),
                                  trailing: CupertinoSwitch(
                                    value: isActive,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          isActive = value;
                                        },
                                      );
                                    },
                                    activeColor: Colors.tealAccent,
                                  ),
                                ),
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: "Delete",
                                    icon: CupertinoIcons.delete_solid,
                                    color: Colors.redAccent,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  childCount: 50),
            ),
          ],
        ),
      ),
    );
  }
}
