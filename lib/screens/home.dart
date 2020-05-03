import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final colors = [
    Colors.red,
    Colors.purple,
    Colors.cyan,
    Colors.teal,
    Colors.green
  ];
  final screens = [
    ProjectScreen(),
    EventScreen(),
    TaskScreen(),
    AlarmScreen(),
    CompletedScreen(),
  ];
  final dialogs = [
    NewProjectDialog(),
    NewEventDialog(),
    NewTaskDialog(),
    NewAlarmDialog()
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
  int _page = 0;
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);
    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  bool checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
       userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
       userPageDragging = false;
    }
    if (userPageDragging) {
       _menuPositionController.findNearestTarget(_pageController.page);
    }
    return userPageDragging;
  }

  @override
  Widget build(BuildContext context) {
    //var colorIndex = widget.titles.indexOf(_page)
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bubbled Navigation Bar'),
      // ),
      backgroundColor: widget.colors[_page],
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
           return checkUserDragging(scrollNotification);
        },
        child: PageView(
          controller: _pageController,
          children: widget.screens
              .map((Widget s) => Container(child: s)) //
              .toList(),
          onPageChanged: (page) {
            setState(() {
              _page = page;
            });
            //print("The page index in page view is $_page");
          },
        ),
      ),
      bottomNavigationBar: BubbledNavigationBar(
        controller: _menuPositionController,
        initialIndex: _page,
        itemMargin: EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Colors.black,
        defaultBubbleColor: Colors.blue,
        onTap: (index) {
          _pageController.animateToPage(index,
              curve: Curves.elasticInOut,
              duration: Duration(milliseconds: 500));
          setState(() {
            _page = index;
          });
          //print("The page index in bubled navigation bar is $_page");
        },
        items: widget.titles.map((title) {
          var index = widget.titles.indexOf(title);
          var color = widget.colors[index];
          return BubbledNavigationBarItem(
            icon: getIcon(index, color),
            activeIcon: getIcon(index, Colors.white),
            bubbleColor: color,
            title: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }).toList(),
      ),
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
                          child: widget.dialogs[_page],
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

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
