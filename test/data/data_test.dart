import 'package:flutter_test/flutter_test.dart';
import 'package:hexagon_glass/data/bloc/data_bloc.dart';
import 'package:hexagon_glass/data/data.dart';

void main() {
  test("Data equal", () {
    var data = const Data(progress: {
      Difficulty.easy: 0,
      Difficulty.medium: 0,
      Difficulty.hard: 0
    });

    var state = DataState.loadData(data: data);
    var state2 = DataState.loadData(data: data);
    assert(state == state2);
  });
}
