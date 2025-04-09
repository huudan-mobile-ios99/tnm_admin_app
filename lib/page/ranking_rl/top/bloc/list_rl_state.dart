part of 'list_rl_bloc.dart';


enum ListRLStatus { initial, success, failure }

class ListRLState extends Equatable{
  const ListRLState({
    this.status = ListRLStatus.initial,
    this.posts = const <RankingRL>[],
    this.hasReachedMax = false,
  });
  final ListRLStatus status;
  final List<RankingRL> posts;
  final bool hasReachedMax;

  ListRLState copyWith({
    ListRLStatus? status,
    List<RankingRL>? posts,
    bool? hasReachedMax,
  }) {
    return ListRLState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  @override
  String toString() {
    return 'listState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

