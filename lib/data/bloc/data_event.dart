part of 'data_bloc.dart';

sealed class DataEvent {
  const DataEvent();
}

class UpdatedProgressEvent extends DataEvent {
  final Difficulty toUpdate;
  const UpdatedProgressEvent(this.toUpdate);
}

class TutorialDoneEvent extends DataEvent {
  const TutorialDoneEvent();
}

class SaveDataEvent extends DataEvent {
  const SaveDataEvent();
}

class LoadDataEvent extends DataEvent {
  final Data loadedData;
  const LoadDataEvent(this.loadedData);
}
