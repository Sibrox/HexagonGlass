import 'dart:convert';

import 'package:hexagon_glass/data/bloc/data_bloc.dart';
import 'package:hexagon_glass/data/data.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('DatBloc', () {
    late Data dataFromFile;

    blocTest("TestLoadData",
        setUp: () {
          String dataStr = '''
        {
          "tutorialDone": false,
          "progress": {
            "easy": 4,
            "medium": 0,
            "hard": 0
          }
        }
      ''';
          dataFromFile = Data.fromJson(jsonDecode(dataStr));
        },
        build: () => DataBloc(),
        act: (bloc) {
          bloc.add(LoadDataEvent(dataFromFile));
        },
        expect: () => [DataState.loadData(data: dataFromFile)]);

    blocTest('Tutorial Done',
        build: () => DataBloc(),
        act: (bloc) => bloc.add(const TutorialDoneEvent()),
        expect: () => [DataState(data: Data.init(tutorialDone: true))]);
  });

  group('DataBloc progress', () {
    blocTest('Progress easy',
        build: () => DataBloc(),
        act: (bloc) => bloc.add(const UpdatedProgressEvent(Difficulty.easy)),
        expect: () {
          return [
            DataState(
                data: Data(tutorialDone: false, progress: {
              Difficulty.easy: 1,
              Difficulty.medium: 0,
              Difficulty.hard: 0
            }))
          ];
        });

    blocTest('Progress easy',
        build: () => DataBloc(),
        act: (bloc) {
          bloc.add(const UpdatedProgressEvent(Difficulty.easy));
          bloc.add(const UpdatedProgressEvent(Difficulty.medium));
          bloc.add(const UpdatedProgressEvent(Difficulty.easy));
          bloc.add(const UpdatedProgressEvent(Difficulty.hard));
        },
        expect: () {
          return [
            DataState(
                data: Data(tutorialDone: false, progress: {
              Difficulty.easy: 1,
              Difficulty.medium: 0,
              Difficulty.hard: 0
            })),
            DataState(
                data: Data(tutorialDone: false, progress: {
              Difficulty.easy: 1,
              Difficulty.medium: 1,
              Difficulty.hard: 0
            })),
            DataState(
                data: Data(tutorialDone: false, progress: {
              Difficulty.easy: 2,
              Difficulty.medium: 1,
              Difficulty.hard: 0
            })),
            DataState(
                data: Data(tutorialDone: false, progress: {
              Difficulty.easy: 2,
              Difficulty.medium: 1,
              Difficulty.hard: 1
            })),
          ];
        });
  });
}
