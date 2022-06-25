import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/screens/level.dart';
import 'package:hexagon_glass/widgets/planet_list_view.dart';

import '../widgets/hexagon_grid.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap:() {Navigator.push(context, MaterialPageRoute(builder: (context) =>  PlanetListView() ));},
            child: Center(
              child: RouteButton(buttonTitle: "Story"),
            )
          ),
          GestureDetector(
              onTap:() {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                    Level()
                  )
                );
              },
              child: Center(
                child: RouteButton(buttonTitle: "Infinity"),
              )
          ),
        ],
      )
    );
  }
}


class RouteButton extends StatelessWidget {
  final String buttonTitle;
  const RouteButton({Key? key, required this.buttonTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0, left:20.0, right: 20.0),
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(child: Text( buttonTitle,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
            )
          )
        ) ,
    );
  }
}
