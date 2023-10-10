import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';

const chooseColor = {
  CellColors.primary: Colors.blue,
  CellColors.secondary: Colors.amber,
  CellColors.grey: Colors.grey
};

class HexagonCell extends StatelessWidget {
  final double size;
  final CellInfo cellInfo;
  const HexagonCell({super.key, required this.cellInfo, this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        width: size,
        child: ClipPolygon(
          sides: 6,
          borderRadius: 0,
          rotate: 60,
          boxShadows: [
            PolygonBoxShadow(
                color: Colors.black, elevation: cellInfo.isVisible ? 5.0 : 0)
          ],
          child: cellInfo.isVisible
              ? Container(
                  decoration: BoxDecoration(
                    color: chooseColor[cellInfo.color],
                  ),
                  child: const Center(
                      child: DefaultTextStyle(
                          style: TextStyle(fontSize: 40, fontFamily: 'Rowdies'),
                          child: StrokeText(
                            text: "2",
                          ))))
              : Container(),
        ));
  }
}
