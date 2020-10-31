import 'package:flutter/material.dart';

class WidgetBackgroundHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -64,
            right: -128,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9000),
                  color: Color(0xFF425195)),
            )),
        Positioned(
            top: -164,
            right: -8,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9000),
                  color: Colors.redAccent.withOpacity(0.8),
                  backgroundBlendMode: BlendMode.hardLight),
            )),
      ],
    );
  }
}
