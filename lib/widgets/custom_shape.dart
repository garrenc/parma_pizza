import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = 400;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 120);
    path.quadraticBezierTo(width / 2, 320, width, height - 120);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
