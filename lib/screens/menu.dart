import 'package:flutter/material.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Flexible(
        //   flex: 1,
        //   child: Center(
        //     child: Text("Space Hex"),
        //   )
        // ),
        Flexible(flex: 6,
            child: PlanetListView()
        ),
        // Flexible(flex: 1,
        //     child: Center(
        //       child: Text("Footer"),
        //     )
        // ),
      ],
    );

  }
}
