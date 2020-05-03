import 'package:arvo/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NewProjectDialog extends StatefulWidget {
  @override
  _NewProjectDialogState createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  List<TextEditingController> _taskControllers = new List();
  int _looper = 1;
  var _formKey, _numbers;
  List<int> numbers = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

  Iterable<int> get positiveIntegers sync* {
    int i = 0;
    while (true) yield i++;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    //_numbers = List<int>.generate(11, (i)=> i+1);
    _numbers = positiveIntegers.skip(1).take(10).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create a new project",
          //textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 25),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.done_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: null)
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          //shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ), //15
            //TODOProject's Name Form Field!!
            Text(
              "Your project's name",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20),
            ),
            ArvoTextFormField(
              controller: _nameController,
              hintText: 'Provide at least five characters',
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.005,
            // ), //5
            //TODOProject's Description Form Field!!
            Text(
              "Your project's description",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20),
            ),
            ArvoTextFormField(
              controller: _descriptionController,
              hintText: 'Provide at least five characters ',
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.005,
            // ), //5
            Text(
              "Pick your projects's date & time",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 20),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.010,
            // ),
            //SizedBox(width: 15),
            //TODODate picker FlatButton!!
            FlatButton(
              onPressed: () {
                print("Generated numbers are $_numbers");
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.calendar_view_day,
                      color: Colors.blue,
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.020,
                    // ), //10
                    Text("2020-05-01"),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25), //70
                    Icon(
                      Icons.access_time,
                      color: Colors.blue,
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.020,
                    // ), //10
                    Text("14:20")
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            //TODOCategories Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                //borderOnForeground: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.150,
                    ), //50
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select a categorie..!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            //color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.080), //40
                    FlatButton.icon(
                      splashColor: Colors.deepOrange,
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.tag_solid,
                        color: Colors.red,
                      ),
                      label: Text("Important"),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.006,
            // ), //5
            //TODONumber of task's Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                //borderOnForeground: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0115,
                    ), //15
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60.0, 0, 5, 0),
                      child: Text(
                        "How many tasks in this project",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            //color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.020,
                    ), //10
                    DropdownButton<int>(
                      isDense: false,
                      isExpanded: false,
                      iconEnabledColor: Colors.blue,
                      iconDisabledColor: Colors.grey,
                      iconSize: 35,
                      focusColor: Colors.indigo,
                      underline: Divider(
                        height: 5,
                        color: Colors.blue,
                        thickness: 2,
                      ),
                      items: numbers
                          .map((e) => DropdownMenuItem<int>(
                                child: Text(
                                  e.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _looper = value);
                      },
                      value: _looper,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0115,
            ), //15
            // Divider(
            //   indent: 12,
            //   thickness: 10,
            //   color: Colors.red,
            //   endIndent: 12,
            // ),
            // Text(
            //   "Now you can fill these $_looper text field",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       fontWeight: FontWeight.w900,
            //       color: Colors.black,
            //       fontSize: 20),
            // ),
            //TODOSub Tasks Text formField!!
            Container(
              height: MediaQuery.of(context).size.height * 0.38, //36
              //color: Colors.grey,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    _taskControllers.add(new TextEditingController());
                    return ArvoTextFormField(
                        controller: _taskControllers[index],
                        hintText: "Task ${index + 1} of the project");
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                  itemCount: _looper),
            ),
          ],
        ),
      ),
    );
  }
}
