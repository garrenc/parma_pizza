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
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/transparent.png',
              image: 'http://parmapizza.ru/upload/1614176492.jpg',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: 330,
            color: Color(0xFF1E1E1E).withOpacity(0.7),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Парма Пицца',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
