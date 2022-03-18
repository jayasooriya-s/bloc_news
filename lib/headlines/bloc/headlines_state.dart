part of 'headlines_bloc.dart';

enum HeadLinesStatus { initial, success, failure }

class HeadlinesState extends Equatable {
  final HeadLinesStatus status;
  final List<HeadLine> headlines;
  bool hasReachedMax;
  HeadlinesState({
    this.status = HeadLinesStatus.initial,
    this.headlines = const <HeadLine>[],
    this.hasReachedMax = false,
  });

  HeadlinesState copyWith({
    HeadLinesStatus? status,
    List<HeadLine>? headlines,
    bool? hasReachedMax,
  }) {
    return HeadlinesState(
      status: status ?? this.status,
      headlines: headlines ?? this.headlines,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${headlines.length} }''';
  }

  @override
  List<Object> get props => [status, headlines, hasReachedMax];
}

class HeadlinesInitial extends HeadlinesState {}
