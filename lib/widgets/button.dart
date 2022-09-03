import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ButtonApp(this.text, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orange)))),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Comic Sans',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
