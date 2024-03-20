import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giphy/models/gif_model.dart';
import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';

part 'display_event.dart';
part 'display_state.dart';

// creating temp variables here only later on cradentials will be moved to environment variable
const String trendingUrl = "https://api.giphy.com/v1/gifs/trending";
const String SearchUrl = "https://api.giphy.com/v1/gifs/search";
const String apiKey = "h0wH9Df21bI2YozIN6PUwFfW562OD4rX";

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  DisplayBloc() : super(const DisplayInitial([], ResponseType.pending)) {
    on<InitialEvent>(_onInitialEvent);
    on<SearchEvent>(_onSearchEvent);
    on<FetchMoreEvent>(_onFetchMoreEvent);
    on<GifsLoadedEvent>(_onGifsLoadedEvent);
  }

  void _onInitialEvent(event, emit) {}
  Future<void> _onSearchEvent(SearchEvent event, emit) async {
    emit(DisplayLoading(state.data, ResponseType.pending));
    final String url = constructSearchQuery(event.keyword);
    var response = await http.get(Uri.parse(url));
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<GifModel> resData =
          (jsonDecode(response.body)["data"] as List<dynamic>)
              .map(
                (e) => GifModel.fromJson(e),
              )
              .toList();
      emit(DisplayLoaded(resData, ResponseType.success));
    } else {
      emit(const DisplayState([], ResponseType.failure));
    }
  }

  void _onFetchMoreEvent(event, emit) {}
  void _onGifsLoadedEvent(event, emit) {}
}

String constructTrendingQuery() {
  return "";
}

String constructSearchQuery(String query, {int limit = 25}) {
  return "$SearchUrl?api_key=$apiKey&q=$query&limit=$limit";
}

String constructPaginationQuery() {
  return "";
}

String constructInitialQuery() {
  return "";
}
