import 'package:flutter/material.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Flexible(child: PlanetListView())
      ],
    );

  }
}
