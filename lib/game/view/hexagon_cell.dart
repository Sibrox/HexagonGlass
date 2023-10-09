import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:hexagon_glass/game/cell_info.dart';

class HexagonCell extends StatefulWidget {
  final double size;
  final CellInfo cellInfo;
  const HexagonCell({super.key, required this.cellInfo, this.size = 15});

  @override
  State<HexagonCell> createState() => _HexagonCellState();
}

class _HexagonCellState extends State<HexagonCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      child: ClipPolygon(
        sides: 6,
        borderRadius: 0,
        rotate: 60,
        boxShadows: [
          PolygonBoxShadow(
              color: Colors.black,
              elevation: widget.cellInfo.isVisible ? 5.0 : 0)
        ],
        child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(child: Text("0")))),
    );
  }
}
