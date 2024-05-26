part of 'top_destination_bloc.dart';

sealed class TopDestinationEvent extends Equatable {
  const TopDestinationEvent();
  @override
  List<Object> get props => [];
}

class OnGetTopDestination extends TopDestinationEvent {}
