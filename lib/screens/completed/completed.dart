import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text("Completed Screen"),
        ),
      ),
    );
  }
}