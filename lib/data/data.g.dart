// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tutorialDone: json['tutorialDone'] as bool? ?? false,
      progress: (json['progress'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$DifficultyEnumMap, k), e as int),
      ),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tutorialDone': instance.tutorialDone,
      'progress':
          instance.progress.map((k, e) => MapEntry(_$DifficultyEnumMap[k]!, e)),
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
