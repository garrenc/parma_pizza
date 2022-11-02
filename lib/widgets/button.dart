import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonApp(this.text, this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: const BorderSide(color: Colors.orange)))),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Comic Sans',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
