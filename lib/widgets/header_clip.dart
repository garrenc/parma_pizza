import 'package:flutter/material.dart';
import '../widgets/custom_shape.dart';

class HeaderClip extends StatelessWidget {
  const HeaderClip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShape(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 300,
            color: const Color(0x0fffffff),
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
