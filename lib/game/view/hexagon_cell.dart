import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:hexagon_glass/game/cell_colors.dart';
import 'package:hexagon_glass/game/cell_info.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';

class HexagonCell extends StatelessWidget {
  final double size;
  final CellInfo cellInfo;
  final PlanetTheme theme;
  const HexagonCell(
      {super.key, required this.cellInfo, required this.theme, this.size = 15});

  Color chooseColor(PlanetTheme theme, CellColors cellColors) {
    switch (cellColors) {
      case CellColors.primary:
        return theme.color_1;
      case CellColors.secondary:
        return theme.color_2;
      case CellColors.grey:
        return theme.no_color;
    }
  }

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
                    color: chooseColor(theme, cellInfo.color),
                  ),
                  child: Center(
                      child: DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 40, fontFamily: 'Rowdies'),
                          child: StrokeText(
                            text: cellInfo.value.toString(),
                          ))))
              : Container(),
        ));
  }
}
