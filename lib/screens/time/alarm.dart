import 'package:arvo/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  //final db = Provider.of<AppDatabase>(context);
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    return StreamProvider.value(
      child: SafeArea(
        child: Container(
          color: Colors.teal,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildHorlogeSliverAppBar(),
              _buildEventConsumer(is24HoursFormat, db)
            ],
          ),
        ),
      ),
      value: db.alarmDao.watchAlarm(),
    );
  }

  Consumer<List<Alarm>> _buildEventConsumer(
      bool is24HoursFormat, AppDatabase db) {
    return Consumer<List<Alarm>>(
      builder: (BuildContext context, value, Widget child) {
        final alarms = value ?? List();
        return (alarms.isEmpty)
            ? _buildEmptyEventSliverFillRemaining()
            : _buildEventSliverList(alarms, is24HoursFormat, db);
      },
    );
  }

  SliverList _buildEventSliverList(
      List<Alarm> alarms, bool is24HoursFormat, AppDatabase db) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final alarm = alarms[index];

        return Column(
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
                    title: (is24HoursFormat)
                        ? Text(
                            DateFormat.Hm().format(alarm.ringTime),
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20),
                          )
                        : Text(
                            DateFormat.jm().format(alarm.ringTime),
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                    subtitle: Text("Alarm"),
                    trailing: CupertinoSwitch(
                      value: alarm.hasRang,
                      onChanged: (value) => db.alarmDao.updateAlarm(
                        alarm.copyWith(hasRang: value),
                      ),
                      activeColor: Colors.redAccent,
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
        );
      }, childCount: alarms.length),
    );
  }

  SliverFillRemaining _buildEmptyEventSliverFillRemaining() {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 55, 10, 5),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "There is no Alarm scheduled for now",
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
    );
  }

  SliverAppBar _buildHorlogeSliverAppBar() {
    //int restHours = DateTime.now().hour - alarmTime.hour;
    return SliverAppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
        ),
      ),
      elevation: 20,
      expandedHeight: 300,
      centerTitle: false,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Ring in 2 hours (awill fix later)",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              fontSize: 20),
        ),
        background: null,
      ),
    );
  }
}
