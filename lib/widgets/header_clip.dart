import 'package:flutter/material.dart';
import '../widgets/custom_shape.dart';

class HeaderClip extends StatelessWidget {
  const HeaderClip({
    Key key,
    this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return ClipPath(
      clipper: CustomShape(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 330,
            color: Color(0xFFFFFFF),
            child: Image.asset(
              'assets/images/shapka.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
