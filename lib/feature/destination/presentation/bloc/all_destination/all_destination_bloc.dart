import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travel_app_fix/feature/destination/domain/entities/destination_entity.dart';

import '../../../domain/usecases/get_all_destination_usecase.dart';

part 'all_destination_event.dart';

part 'all_destination_state.dart';

class AllDestinationBloc
    extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetAllDestinationUseCase _useCase;

  AllDestinationBloc(this._useCase) : super(AllDestinationInitial()) {
    on<AllDestinationEvent>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await _useCase();
      result.fold((failure) => emit(AllDestinationFailure(failure.message)),
          (data) => emit(AllDestinationLoaded(data)));
    });
  }
}
