import 'package:flutter/material.dart';

class InfoAlertBox extends StatelessWidget {
  final String title;
  final List<String> info;
  final String warning;
  final String minimum;
  const InfoAlertBox({Key? key, required this.warning, required this.title, required this.info, required this.minimum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Text(title),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: LimitedBox(
        maxHeight: 400,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text('-${info[i]}'),
                    ),
                itemCount: info.length),
            Text(minimum),
            const SizedBox(
              height: 30,
            ),
            Text(warning, style: const TextStyle(color: Colors.red, fontSize: 15))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
