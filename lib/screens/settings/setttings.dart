import 'package:arvo/screens/tags/new_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Arvo Configurations"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text("Tags - Settings"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Let's create your own tag(s)",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.create_solid,
                  size: 35,
                ),
                onPressed: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Dialog(
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: NewTag(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
