import 'package:flutter/material.dart';

class ArvoTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;

  const ArvoTextFormField(
      {Key key,
      @required this.controller,
      @required this.hintText,
       this.labelText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            //fontStyle: FontStyle.italic,
            
            fontSize: 18,
          ),
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              Text("This text field can't be empty!!");
              return "This text field can't be empty..!!";
            } else
              return null;
          },
        ),
      ),
    );
  }
}
