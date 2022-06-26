import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ],
    );
  }
}
