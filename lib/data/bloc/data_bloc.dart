import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon_glass/data/data.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState.init()) {
    on<LoadDataEvent>((event, emit) {
      emit(DataState.loadData(data: event.loadedData));
    });

    on<TutorialDoneEvent>((event, emit) => emit(DataState.updateData(
        currentState: state,
        data: Data(
            progress: Map.from(state.data.progress), tutorialDone: true))));

    on<UpdatedProgressEvent>((event, emit) =>
        emit(DataState(data: Data.updateProgress(state.data, event.toUpdate))));
  }
}
