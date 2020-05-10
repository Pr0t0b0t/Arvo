import 'package:arvo/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

class _EventScreenState extends State<EventScreen>
    with TickerProviderStateMixin {
  //AnimationController _animationController;
  bool isChecked = false;
  CalendarController _calendarController;

  //Map<DateTime, dynamic> _customEvents;

  DateTime _selectedDate;
  AnimationController _animationController;
  AppDatabase db;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDate = DateTime.now();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    //initDatabase();
  }

  // initDatabase() {
  //   db = Provider.of<AppDatabase>(context);
  //   setState(() {
  //     _events = Map<DateTime, List<dynamic>>.from(
  //         decodeMap(json.decode(db.events.toString() ?? "{}")));
  //   });
  // }

  //<AppDatabase>
  // Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  //   Map<String, dynamic> newMap = {};
  //   map.forEach((key, value) {
  //     newMap[key.toString()] = map[key];
  //   });
  //   return newMap;
  // }

  // Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  //   Map<DateTime, dynamic> newMap = {};
  //   map.forEach((key, value) {
  //     newMap[DateTime.parse(key)] = map[key];
  //   });
  //   return newMap;
  // }

  @override
  Widget build(BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final evDao = Provider.of<EventDao>(context);
    return SafeArea(
      child: StreamBuilder<List<EventWithTag>>(
        stream: evDao.watchUnCompletedEvents(),
        builder: (context, snapshot) {
          final eventsWithTag = snapshot.data ?? List();
          final Map<DateTime, List<dynamic>> _generalEvents = Map.fromIterable(
            eventsWithTag,
            key: (e) => e.event.startDate,
            value: (e) => [e.event.evName],
          );

          // print("Events in streamBuilder length is ${snapshot.data.length}");
          // print("The map of streamBuilder event is $_generalEvents");
          return StreamProvider.value(
            child: Consumer<List<EventWithTag>>(
              builder: (BuildContext context, value, Widget child) {
                final specificEventsWithTag = value ?? List();
                final Map<DateTime, List<dynamic>> _specificEvents =
                    Map.fromIterable(
                  specificEventsWithTag,
                  key: (e) => e.event.startDate,
                  value: (e) => [e.event.evName],
                );
                // print(
                //     "Events in streamProvider length is ${specificEventsWithTag.length}");
                // print(
                //     "The map of streamProvider event length is ${_specificEvents.length} and elements are $_specificEvents");

                return CustomScrollView(
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
                              //fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                        titlePadding: EdgeInsets.fromLTRB(10, 15, 10, 8),
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        background: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                          child: TableCalendar(
                            builders: CalendarBuilders(
                              markersBuilder: (context, date,
                                  specificEventsWithTag, holidays) {
                                final children = <Widget>[];
                                // print(
                                //     "In builders events are ${_specificEvents.length}");
                                if (_generalEvents.isNotEmpty) {
                                  children.add(
                                    Positioned(
                                      right: 1,
                                      bottom: 1,
                                      child:
                                          _buildAnimatedContainerOfEventsMarker(
                                              date,
                                              _generalEvents,
                                              eventsWithTag),
                                    ),
                                  );
                                }
                                if (holidays.isNotEmpty) {
                                  children.add(
                                    Positioned(
                                      right: 1,
                                      top: 1,
                                      child: Icon(
                                        Icons.insert_emoticon,
                                        size: 20.0,
                                        color: Colors.red[800],
                                      ),
                                    ),
                                  );
                                }
                                return children;
                              },
                            ),
                            events: _generalEvents,
                            //initialCalendarFormat: CalendarFormat.week,
                            calendarController: _calendarController,
                            headerStyle: HeaderStyle(
                                titleTextStyle: TextStyle(
                                    color: Colors.black,
                                    //fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                                formatButtonTextStyle: TextStyle(
                                    color: Colors.black,
                                    //fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                                rightChevronIcon:
                                    Icon(Icons.chevron_right, size: 30),
                                leftChevronIcon:
                                    Icon(Icons.chevron_left, size: 30)),
                            calendarStyle: CalendarStyle(
                              canEventMarkersOverflow: true,
                              renderDaysOfWeek: true,
                              selectedColor: Colors.amber,
                              todayColor: Colors.deepOrange,
                              markersColor: Colors.brown[700],
                              outsideDaysVisible: true,
                              holidayStyle: TextStyle(
                                  //color: Color(0xFFF44336),
                                  //fontStyle: FontStyle.italic,
                                  //fontWeight: FontWeight.w900,
                                  fontSize: 17),
                              outsideStyle: TextStyle(
                                  color: Colors.greenAccent,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                              outsideWeekendStyle: TextStyle(
                                  color: Colors.greenAccent,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                              weekdayStyle: TextStyle(
                                  color: Colors.white,
                                  //fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                              weekendStyle: TextStyle(
                                  //color: Color(0xFFF44336),
                                  //fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  //color: Color(0xFF616161),
                                  //fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                              weekendStyle: TextStyle(
                                  // color: Color(0xFFF44336),
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17),
                            ),
                            holidays: _holidays,
                            //builders: CalendarBuilders(markersBuilder: (_,)),
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            onDaySelected: (selectedDate, evs) {
                              print(
                                  "The length of events at ${selectedDate.day} is ${evs.length} and values are $evs");
                              _animationController.forward(from: 0.0);
                              evDao.specificDayEvents(selectedDate);
                              setState(() {
                                _selectedDate = selectedDate;
                              });
                              for (var i = 0; i < eventsWithTag.length; i++) {
                                print("The i is $i ${eventsWithTag[i]}");
                                if (eventsWithTag[i].event.startDate.day ==
                                    _selectedDate.day) {
                                  print(
                                      "The same date time event's length is ${eventsWithTag.length}");
                                }
                              }
                              var eqList = eventsWithTag
                                  .where((element) =>
                                      element.event.startDate.day ==
                                      selectedDate.day)
                                  .toList();
                              print("Equal list is ${eqList.length}");
                              _onDaySelected(_selectedDate, evs);
                              //print("Events lenght is ${_allEvents.length}");
                            },
                          ),
                        ),
                      ),
                    ),
                    (specificEventsWithTag.isEmpty)
                        ? _emptyEventSliverBuilder(_selectedDate)
                        : _buildEventSliverList(
                            specificEventsWithTag, evDao, is24HoursFormat)
                    // StreamProvider.value(
                    //   child: Consumer<List<EventWithTag>>(
                    //     builder: (BuildContext context, value, Widget child) {
                    //       final events = value ?? List();
                    //       // /*var evMap*/ _events = Map.fromIterable(
                    //       //   events,
                    //       //   key: (e) => e.event.startDate,
                    //       //   value: (e) => e.event.evName,
                    //       // );
                    //       print(
                    //           "Events in StreamProvider length is ${events.length}");
                    //       print("The map of StreamProvider event is $_events");
                    //       return (events.isEmpty)
                    //           ? _emptyEventSliverBuilder(_selectedDate)
                    //           : _buildEventSliverList(
                    //               events, evDao, is24HoursFormat);
                    //     },
                    //   ),
                    //   value: evDao.specificDayEvents(_selectedDate),
                    // )
                  ],
                );
              },
            ),
            value: evDao.specificDayEvents(_selectedDate),
          );
        },
      ),
    );
  }

  AnimatedContainer _buildAnimatedContainerOfEventsMarker(DateTime date,
      Map<DateTime, List> _generalEvents, List<EventWithTag> eventsWithTag) {
    //var generalEventList = [];
    //_generalEvents
    var eqList = eventsWithTag
        .where((element) => element.event.startDate.day == date.day)
        .toList();
    print("Equal list is ${eqList.length}");
    return AnimatedContainer(
      width: 17,
      height: 17,
      duration: const Duration(microseconds: 350),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.red[400],
      ),
      child: Center(
        child: Text(
          "${eqList.length}",
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime dateTime, List evs) {
    return print(
        "The selected date is ${dateTime.day} and it got ${evs.length} element");
  }

  SliverList _buildEventSliverList(
      List events, EventDao evDao, bool is24HoursFormat) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final ev = events[index];
        return Column(
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
                      SizedBox(width: 5),
                      Container(
                        height: 50,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Color(ev.tag.color),
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
                          title: Text(ev.event.evName),
                          subtitle: Text(ev.event.description),
                          secondary: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 12),
                                  (is24HoursFormat)
                                      ? Text(DateFormat.Hm()
                                          .format(ev.event.startDate))
                                      : Text(DateFormat.jm()
                                          .format(ev.event.startDate)),
                                  SizedBox(height: 5),
                                  Text(DateFormat("EEE dd MM")
                                      .format(ev.event.endDate))
                                ],
                              ),
                            ],
                          ),
                          //selected: false,
                          value: ev.event.isHappened,
                          onChanged: (value) => evDao.updateEvent(
                              ev.event.copyWith(isHappened: value)),
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
                      onTap: () => evDao.deleteEvent(ev.event),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }, childCount: events.length),
    );
  }

  SliverFillRemaining _emptyEventSliverBuilder(DateTime _selectedDate) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 8,),
            Icon(
              Icons.insert_invitation,
              size: 150,
              color: Colors.white,
            ),
            SizedBox(height: 12),
            Text(
              "Nothing were scheduled at ${_selectedDate.day} ${DateFormat.MMM().format(_selectedDate)}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 12),
            Text(
              "Choose a day to display his scheduled events",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Slide to left on an event's tile to delete..!!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SliverAppBar _buildEmptySliverAppBar() {
  //   return SliverAppBar(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         bottomRight: Radius.circular(35),
  //         bottomLeft: Radius.circular(35),
  //       ),
  //     ),
  //     elevation: 20,
  //     expandedHeight: 450.0,
  //     floating: false,
  //     pinned: true,
  //     flexibleSpace: FlexibleSpaceBar(
  //       title: Text(
  //         "Calendar",
  //         style: TextStyle(
  //             color: Colors.white,
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 20),
  //       ),
  //       titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 8),
  //       collapseMode: CollapseMode.parallax,
  //       centerTitle: true,
  //       background: Padding(
  //         padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 10),
  //         child: _buildEmptyTableCalendar(),
  //       ),
  //     ),
  //   );
  // }

  // TableCalendar _buildEmptyTableCalendar() {
  //   return TableCalendar(
  //     calendarController: _calendarController,
  //     headerStyle: HeaderStyle(
  //         titleTextStyle: TextStyle(
  //             color: Colors.black,
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 20),
  //         formatButtonTextStyle: TextStyle(
  //             color: Colors.black,
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 20),
  //         rightChevronIcon: Icon(Icons.chevron_right, size: 30),
  //         leftChevronIcon: Icon(Icons.chevron_left, size: 30)),
  //     calendarStyle: CalendarStyle(
  //       renderDaysOfWeek: true,
  //       selectedColor: Colors.amber,
  //       todayColor: Colors.deepOrange,
  //       markersColor: Colors.brown[700],
  //       outsideDaysVisible: true,
  //       holidayStyle: TextStyle(
  //           //color: Color(0xFFF44336),
  //           //fontStyle: FontStyle.italic,
  //           //fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //       outsideStyle: TextStyle(
  //           color: Colors.greenAccent,
  //           fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //       outsideWeekendStyle: TextStyle(
  //           color: Colors.greenAccent,
  //           fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //       weekdayStyle: TextStyle(
  //           color: Colors.white,
  //           //fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //       weekendStyle: TextStyle(
  //           //color: Color(0xFFF44336),
  //           //fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //     ),
  //     daysOfWeekStyle: DaysOfWeekStyle(
  //       weekdayStyle: TextStyle(
  //           //color: Color(0xFF616161),
  //           //fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //       weekendStyle: TextStyle(
  //           // color: Color(0xFFF44336),
  //           // fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w900,
  //           fontSize: 17),
  //     ),
  //     holidays: _holidays,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     //onDaySelected: (selectedDate, events) {},
  //   );
  // }

  // Widget _buildTableCalendar() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 10),
  //     child: TableCalendar(
  //       calendarController: _calendarController,
  //       headerStyle: HeaderStyle(
  //           titleTextStyle: TextStyle(
  //               color: Colors.black,
  //               //fontStyle: FontStyle.italic,
  //               fontWeight: FontWeight.w900,
  //               fontSize: 20),
  //           formatButtonTextStyle: TextStyle(
  //               color: Colors.black,
  //               //fontStyle: FontStyle.italic,
  //               fontWeight: FontWeight.w900,
  //               fontSize: 20),
  //           rightChevronIcon: Icon(Icons.chevron_right, size: 30),
  //           leftChevronIcon: Icon(Icons.chevron_left, size: 30)),
  //       calendarStyle: CalendarStyle(
  //         renderDaysOfWeek: true,
  //         selectedColor: Colors.amber,
  //         todayColor: Colors.deepOrange,
  //         markersColor: Colors.brown[700],
  //         outsideDaysVisible: true,
  //         holidayStyle: TextStyle(
  //             //color: Color(0xFFF44336),
  //             //fontStyle: FontStyle.italic,
  //             //fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //         outsideStyle: TextStyle(
  //             color: Colors.greenAccent,
  //             fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //         outsideWeekendStyle: TextStyle(
  //             color: Colors.greenAccent,
  //             fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //         weekdayStyle: TextStyle(
  //             color: Colors.white,
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //         weekendStyle: TextStyle(
  //             //color: Color(0xFFF44336),
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //       ),
  //       daysOfWeekStyle: DaysOfWeekStyle(
  //         weekdayStyle: TextStyle(
  //             //color: Color(0xFF616161),
  //             //fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //         weekendStyle: TextStyle(
  //             // color: Color(0xFFF44336),
  //             // fontStyle: FontStyle.italic,
  //             fontWeight: FontWeight.w900,
  //             fontSize: 17),
  //       ),
  //       holidays: _holidays,
  //       startingDayOfWeek: StartingDayOfWeek.sunday,
  //       onDaySelected: (selectedDate, _holidays) {},
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
}

/**Consumer<List<EventWithTag>>(
                builder: (BuildContext context, List value, Widget child) {
                  final events = value ?? List();
                  return (events.isEmpty)
                      ? SliverFillRemaining(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 55, 10, 5),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "There is no event scheduled for now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Slide to left on an event's tile to delete..!!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            final ev = events[index];
                            return Column(
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
                                          SizedBox(width: 5),
                                          Container(
                                            height: 50,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              color: Color(ev.tag.color),
                                              borderRadius: BorderRadius.only(
                                                //topRight: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CheckboxListTile(
                                              activeColor: Colors.transparent,
                                              checkColor: Colors.green,
                                              title: Text(ev.event.evName),
                                              subtitle:
                                                  Text(ev.event.description),
                                              secondary: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 12),
                                                      (is24HoursFormat)
                                                          ? Text(DateFormat.Hm()
                                                              .format(ev.event
                                                                  .startDate))
                                                          : Text(DateFormat.jm()
                                                              .format(ev.event
                                                                  .startDate)),
                                                      SizedBox(height: 5),
                                                      Text(DateFormat(
                                                              "EEE dd MM")
                                                          .format(
                                                              ev.event.endDate))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              //selected: false,
                                              value: ev.event.isHappened,
                                              onChanged: (value) =>
                                                  evDao.updateEvent(ev.event
                                                      .copyWith(
                                                          isHappened: value)),
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
                                          onTap: () =>
                                              evDao.deleteEvent(ev.event),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }, childCount: events.length),
                        );
                },
              ) */
