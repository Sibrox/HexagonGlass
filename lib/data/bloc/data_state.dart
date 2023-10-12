part of 'data_bloc.dart';

class DataState extends Equatable {
  final bool loaded;
  final Data data;

  const DataState({required this.data, this.loaded = false});
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
  String toString() {
    return data.toString();
  }

  @override
  List<Object?> get props => [loaded, data];
}
