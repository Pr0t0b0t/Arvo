import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Completed Things"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     CupertinoIcons.settings_solid,
          //     color: Colors.black,
          //     size: 30,
          //   ),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Settings(),
          //     ),
          //   ),
          // ),
          // FlatButton.icon(
          //     onPressed: () {},
          //     icon: Icon(CupertinoIcons.settings_solid),
          //     label: Text("settings")),
        ],
      ),
      body: Column(
        children: <Widget>[Text("data")],
      ),
    );
  }
}
