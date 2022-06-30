import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {

  final String text;
  final double fontSize;

  const StrokeText({
    Key? key,
    required this.text,
    this.fontSize = 20,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        // The text border
        Text(text,
            style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black,
        ),
      ),
    // The text inside
      Text(text,
          style:  TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          ),
          ),
      ],
    );
  }
}
