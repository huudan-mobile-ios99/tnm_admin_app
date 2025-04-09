part of 'station_bloc.dart';


enum StationStatus { initial, success, failure }


class StationState extends Equatable {
  const StationState({
    this.status = StationStatus.initial,
    this.posts,
    this.hasReachedMax = false,
  });

  final StationStatus status;
  final ListStationModel? posts;
  final bool hasReachedMax;

  StationState copyWith({
    StationStatus? status,
    ListStationModel? posts,
    bool? hasReachedMax,
  }) {
    return StationState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    final postCount = posts?.list.length ?? 0;
    return 'station {status: $status, hasReachedMax: $hasReachedMax, stations: $postCount}';
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];
}
