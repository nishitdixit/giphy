part of 'display_bloc.dart';

@immutable
sealed class DisplayEvent {}

class InitialEvent extends DisplayEvent {}

class SearchEvent extends DisplayEvent {
  final String keyword;
  SearchEvent(this.keyword);
}

class GifsLoadedEvent extends DisplayEvent {}

class FetchMoreEvent extends DisplayEvent {
  final int skip;
  final int limit;
  FetchMoreEvent(this.skip, this.limit);
}
