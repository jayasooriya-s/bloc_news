import 'package:bloc/bloc.dart';
import 'package:bloc_news/headlines/models/headline.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'headlines_event.dart';
part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  HeadlinesBloc({required this.httpClient}) : super(HeadlinesState()) {
    on<HeadLinesFetched>(_onHeadLineFetched);
  }
  final http.Client httpClient;
  Future<void> _onHeadLineFetched(
      HeadLinesFetched event, Emitter<HeadlinesState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HeadLinesStatus.initial) {
        final headlines = await _fetchPosts();
        return emit(
          state.copyWith(
              status: HeadLinesStatus.success,
              headlines: headlines,
              hasReachedMax: false),
        );
      }
      final headlines = await _fetchPosts(state.headlines.length);
      emit(headlines.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: HeadLinesStatus.success,
              headlines: List.of(state.headlines)..addAll(headlines),
            ));
    } catch (_) {
      emit(state.copyWith(status: HeadLinesStatus.failure));
    }
  }
}
