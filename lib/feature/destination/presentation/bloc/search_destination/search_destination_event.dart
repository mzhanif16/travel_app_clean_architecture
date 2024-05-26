part of 'search_destination_bloc.dart';

sealed class SearchDestinationEvent extends Equatable {
  const SearchDestinationEvent();

  @override
  List<Object> get props => [];
}

class OnSearchDestination extends SearchDestinationEvent {
  final String query;

  const OnSearchDestination(this.query);

  @override
  List<Object> get props => [query];
}

class OnResetSearchDestination extends SearchDestinationEvent {}
