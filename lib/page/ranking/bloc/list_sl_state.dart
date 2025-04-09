part of 'list_sl_bloc.dart';


enum ListSLStatus { initial, success, failure }

class ListSLState extends Equatable{
  const ListSLState({
    this.status = ListSLStatus.initial,
    this.posts = const <RankingRL>[],
    this.hasReachedMax = false,
  });
  final ListSLStatus status;
  final List<RankingRL> posts;
  final bool hasReachedMax;

  ListSLState copyWith({
    ListSLStatus? status,
    List<RankingRL>? posts,
    bool? hasReachedMax,
  }) {
    return ListSLState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  String toString() {
    return 'ListSLState:  { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

