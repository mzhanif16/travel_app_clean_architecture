
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app_fix/feature/destination/domain/usecases/search_destination_usecase.dart';

import '../../../domain/entities/destination_entity.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final SearchDestinationUseCase _useCase;
  SearchDestinationBloc(this._useCase) : super(SearchDestinationInitial()) {
    on<OnSearchDestination>((event, emit) async{
      emit(SearchDestinationLoading());
      final result = await _useCase(event.query);
      result.fold((failure) => emit(SearchDestinationFailure(failure.message)),
              (data) => emit(SearchDestinationLoaded(data)));
    });
    on<OnResetSearchDestination>((event, emit) {
      emit(SearchDestinationInitial());
    });
  }
}
