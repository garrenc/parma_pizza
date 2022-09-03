import 'package:flutter/material.dart';

class InfoAlertBox extends StatelessWidget {
  final String title;
  final String text;
  const InfoAlertBox({Key key, this.text, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Text(title),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Text(text),
      backgroundColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}

