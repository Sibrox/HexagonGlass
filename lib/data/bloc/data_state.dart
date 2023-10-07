part of 'data_bloc.dart';

class DataState {
  final bool loaded;
  final Data data;

  DataState({required this.data, this.loaded = false});
  factory DataState.init() {
    return DataState(data: Data.init());
  }

  factory DataState.loadData({required data}) {
    return DataState(loaded: true, data: data);
  }

  factory DataState.updateData({required currentState, required data}) {
    return DataState(data: data, loaded: currentState.loaded);
  }

  @override
  bool operator ==(Object other) {
    return other is DataState && loaded == other.loaded && data == other.data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() {
    return data.toString();
  }
}
