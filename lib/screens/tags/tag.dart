import 'package:arvo/screens/completed/setttings.dart';
import 'package:arvo/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Tag choosedTag;
class TagsList extends StatefulWidget {
  @override
  _TagsListState createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Choose a tag",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 25),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              Consumer<List<Tag>>(
                builder: (BuildContext context, List value, Widget child) {
                  final tags = value ?? List();
                  print("Tags length in the table is ${tags.length}");
                  return (tags.isEmpty)
                      ? Column(
                          children: <Widget>[
                            Text("There is no tags for now "),
                            CupertinoButton(
                                child: Text("Create one"),
                                onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Settings(),
                                      ),
                                    ) //NewTag(),
                                )
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final tag = tags[index];
                                for(int i=0; i< tags.length; i++){
                                  print("Tag $i color is ${tag.color} and name is ${tag.name}");
                                }
                                return InkWell(
                                  onTap: () {
                                    print("The tag ${tag.name} was tapped");
                                    setState(() {
                                    choosedTag = tag;
                                    });
                                  },
                                  child: Card(
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    color: Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25.0, 0, 25, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(
                                            CupertinoIcons.tag_solid,
                                            color: Color(
                                                tag.color), //Colors.black87,
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.155,
                                          ),
                                          Text(
                                            tag.name,
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: tags.length),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
