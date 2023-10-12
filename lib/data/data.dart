import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

enum Difficulty {
  @JsonValue("easy")
  easy,
  @JsonValue("medium")
  medium,
  @JsonValue("hard")
  hard
}

@JsonSerializable()
class Data {
  bool tutorialDone;
  final Map<Difficulty, int> progress;

  Data({this.tutorialDone = false, required this.progress});

  factory Data.init({tutorialDone = false}) {
    const progress = {
      Difficulty.easy: 0,
      Difficulty.medium: 0,
      Difficulty.hard: 0
    };

    return Data(tutorialDone: tutorialDone, progress: progress);
  }

  factory Data.updateProgress(Data data, Difficulty difficulty) {
    Map<Difficulty, int> newProgress = Map.from(data.progress);
    newProgress[difficulty] = newProgress[difficulty]! + 1;
    return Data(progress: newProgress, tutorialDone: data.tutorialDone);
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.tutorialDone == tutorialDone &&
        mapEquals(other.progress, progress);
  }

  @override
  int get hashCode => progress.hashCode;

  @override
  String toString() {
    return const JsonEncoder.withIndent('  ').convert(toJson());
  }
}
