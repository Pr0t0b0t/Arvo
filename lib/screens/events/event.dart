import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
  DateTime(2020, 5, 1): ['Work Day'],
  DateTime(2020, 12, 25): ['Noel'],
  DateTime(2020, 12, 31): ['Reveillon']
};

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  //AnimationController _animationController;
  bool isChecked = false;
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    //_animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.purple,
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
              expandedHeight: 450.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Calendar",
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 18),
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                background: _buildTableCalendar(),
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
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  //bottomLeft: Radius.circular(25),
                                ),
                              ),
                              //margin: EdgeInsets.only(left: 20, right: 20),
                              margin: EdgeInsets.all(8),
                              elevation: 15,
                              child: Slidable(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width:5),
                                    Container(
                                      height: 50,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.only(
                                          //topRight: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CheckboxListTile(
                                        activeColor: Colors.transparent,
                                        checkColor: Colors.green,
                                        title: Text("Event's $index title"),
                                        subtitle: Text("Event's description"),
                                        secondary: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            // // Container(
                                            // //   width: 5,
                                            // //   color: Colors.deepOrange,
                                            // // ),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(height: 12),
                                                Text("Categorie"),
                                                SizedBox(height: 5),
                                                Text("Time")
                                              ],
                                            ),
                                          ],
                                        ),
                                        selected: false,
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    color: Colors.red,
                                    caption: "Delete",
                                    icon: CupertinoIcons.delete_solid,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  childCount: 50),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 10),
      child: TableCalendar(
        calendarController: _calendarController,
        headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                fontSize: 20),
            formatButtonTextStyle: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                fontSize: 20),
            rightChevronIcon: Icon(Icons.chevron_right, size: 30),
            leftChevronIcon: Icon(Icons.chevron_left, size: 30)),
        calendarStyle: CalendarStyle(
          renderDaysOfWeek: true,
          selectedColor: Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown[700],
          outsideDaysVisible: true,
          holidayStyle: TextStyle(
              color: Color(0xFFF44336),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
          outsideStyle: TextStyle(
              color: Colors.brown,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
          outsideWeekendStyle: TextStyle(
              color: Color(0xFFEF9A9A),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
          weekdayStyle: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
          weekendStyle: TextStyle(
              color: Color(0xFFF44336),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
          weekendStyle: TextStyle(
              color: Color(0xFFF44336),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 17),
        ),
        holidays: _holidays,
        startingDayOfWeek: StartingDayOfWeek.sunday,
      ),
    );
  }

  @override
  void dispose() {
    //_animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
}