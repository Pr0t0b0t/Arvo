import 'package:arvo/service/database.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'completed/completed.dart';
import 'events/event.dart';
import 'events/new_event.dart';
import 'project/new_project.dart';
import 'project/project.dart';
import 'tasks/new_task.dart';
import 'tasks/task.dart';
import 'time/alarm.dart';
import 'time/new_alarm.dart';

class MyHomePage extends StatefulWidget {
  //static final db = AppDatabase();
  final colors = [
    Colors.red,
    Colors.purple,
    Colors.cyan,
    Colors.teal,
    Colors.green
  ];

  final titles = ['Main', 'Events', 'Tasks', 'Time', 'Completed'];
  final icons = [
    CupertinoIcons.home,
    Icons.date_range,
    CupertinoIcons.news,
    CupertinoIcons.clock,
    CupertinoIcons.check_mark_circled,
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page;
  var _dialogs;
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;
  // AppDatabase db;
  // EventDao eventDao;
  // TaskDao taskDao;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);
    super.initState();
    // db = AppDatabase();
    // eventDao = EventDao(db);
    // taskDao = TaskDao(db);
    _page = 0;
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    //print("Page value is $_page ");
    _dialogs = [
      NewProjectDialog(),
      StreamProvider.value(
        child: NewEventDialog(),
        value: db.tagDao.watchTags(),
      ),
      NewTaskDialog(),
      NewAlarmDialog()
    ];
    return Scaffold(
      backgroundColor: widget.colors[_page],
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _page = index);
          },
          children: <Widget>[
            ProjectScreen(),
            StreamProvider.value(
              child: EventScreen(),
              value: db.eventDao.watchUnCompletedEvents(),
            ),
            StreamProvider.value(
              child: TaskScreen(),
              value: db.taskDao.watchUnCompletedTasks(),
            ),
            AlarmScreen(),
            CompletedScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: (_page < 4)
          ? FloatingActionButton(
              onPressed: () {
                //print("The page in show dialog is $_page");
                return (_page == 0)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewProjectDialog(),
                        ),
                      )
                    : showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.white,
                          child: _dialogs[_page],
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      );
              },
              child: Icon(CupertinoIcons.add_circled_solid),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  BottomNavyBar _buildBottomNavigationBar() {
    return BottomNavyBar(
      backgroundColor: Colors.black,
      selectedIndex: _page,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          activeColor: widget.colors.elementAt(0),
          icon: Icon(
            CupertinoIcons.home,
          ),
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          activeColor: widget.colors.elementAt(1),
          icon: Icon(
            Icons.date_range,
          ),
          title: Text(
            "Events",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          activeColor: widget.colors.elementAt(2),
          icon: Icon(
            CupertinoIcons.news,
          ),
          title: Text(
            "Tasks",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          activeColor: widget.colors.elementAt(3),
          icon: Icon(
            CupertinoIcons.clock,
          ),
          title: Text(
            "Time",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        ),
        BottomNavyBarItem(
          textAlign: TextAlign.center,
          activeColor: widget.colors.elementAt(4),
          icon: Icon(
            CupertinoIcons.check_mark_circled,
          ),
          title: Text(
            "Completed",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
        )
      ],
      onItemSelected: (index) {
        setState(() => _page = index);
        _pageController.jumpToPage(index);
      },
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
