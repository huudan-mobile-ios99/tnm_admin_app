import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:tnm_app_slot_aft/model/rankingRLModel.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';

import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'list_rl_event.dart';
part 'list_rl_state.dart';

final service_api = ServiceAPIsRL();
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListRLBloc extends Bloc<ListRLEvent, ListRLState> {
  final http.Client httpClient;
  ListRLBloc({required this.httpClient}) : super(const ListRLState()){
    on<ListRLFetched>(
      _onListFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }

  Future<void> _onListFetched(ListRLFetched event,Emitter<ListRLState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ListRLStatus.initial) {
        final posts = await service_api.fetchRankingRL();
        return emit(
          state.copyWith(
            status: ListRLStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await service_api.fetchRankingRL(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ListRLStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: ListRLStatus.failure));
    }
  }

}
