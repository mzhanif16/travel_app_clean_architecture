import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/destination_entity.dart';
import '../../../domain/usecases/get_top_destination_usecase.dart';

part 'top_destination_event.dart';

part 'top_destination_state.dart';

class TopDestinationBloc
    extends Bloc<TopDestinationEvent, TopDestinationState> {
  final GetTopDestinationUseCase _useCase;

  TopDestinationBloc(this._useCase) : super(TopDestinationInitial()) {
    on<TopDestinationEvent>((event, emit) async {
      emit(TopDestinationLoading());
      final result = await _useCase();
      result.fold((failure) => emit(TopDestinationFailure(failure.message)),
          (data) => emit(TopDestinationLoaded(data)));
    });
  }
}
