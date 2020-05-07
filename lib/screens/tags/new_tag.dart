import 'package:arvo/service/database.dart';
import 'package:arvo/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class NewTag extends StatefulWidget {
  @override
  _NewTagState createState() => _NewTagState();
}

class _NewTagState extends State<NewTag> {
  TextEditingController _tagController;
  static const DEFAULT_COLOR = Colors.green;
  Color pickedTagColor = DEFAULT_COLOR;
  var _tagFormKey;
  @override
  void initState() {
    // TODOimplement initState of setttings
    super.initState();
    _tagController = TextEditingController();
    _tagFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final tagDao = Provider.of<TagDao>(context, listen: false);
    return SafeArea(
      child: Form(
        key: _tagFormKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Creating the new tag",
              style: TextStyle(fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            ArvoTextFormField(controller: _tagController, hintText: "Tag name"),
            Padding(
              padding: const EdgeInsets.fromLTRB(22.0, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Choose your tag's color"),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.tag_solid,
                      color: pickedTagColor,
                      size: 35,
                    ),
                    onPressed: () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        content: MaterialColorPicker(
                          shrinkWrap: true,
                          selectedColor: DEFAULT_COLOR,
                          onMainColorChange: (colorSwatch) {
                            setState(() => pickedTagColor = colorSwatch);
                            Navigator.of(context).pop();
                            
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                MaterialButton(
                  onPressed: () => setState(
                    () {
                      if (_tagFormKey.currentState.validate()) {
                        _tagFormKey.currentState.save();

                        final tag = TagsCompanion(
                          name: Value(_tagController.text),
                          color: Value(pickedTagColor.value),
                        );
                        print("Tag name is ${tag.name.value} and color is ${tag.color.value}");
                        //_resetEverythings();
                        var result = tagDao
                            .insertTag(tag)
                            .whenComplete(() => _resetEverythings());
                        (result != null)
                            ? print(
                                "Tag ${tag.name.value} saved successfully with the color of ${tag.color.value}")
                            : print("Failed to save the new tag");
                      }
                    },
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _resetEverythings() {
    setState(() {
      _tagController.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODOimplement Tag dispose
    super.dispose();
    _tagController.clear();
    _tagController.dispose();
  }
}
