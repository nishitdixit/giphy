part of 'display_bloc.dart';

enum ResponseType { success, failure, pending }

@immutable
final class DisplayState extends Equatable {
  final List<GifModel> data;
  final ResponseType responseType;
  const DisplayState(this.data, this.responseType);

  DisplayState copyWith(
      {required List<GifModel> newData,
      required ResponseType newResponseType}) {
    return DisplayState(newData, newResponseType);
  }

  @override
  List<Object?> get props => data;
}

final class DisplayInitial extends DisplayState {
  const DisplayInitial(super.data, super.responseType);
}

final class DisplayLoaded extends DisplayState {
  const DisplayLoaded(super.data, super.responseType);
}

final class DisplayLoading extends DisplayState {
  const DisplayLoading(super.data, super.responseType);
}
