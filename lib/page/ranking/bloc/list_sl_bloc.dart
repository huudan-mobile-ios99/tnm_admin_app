import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:tnm_app_slot_aft/model/rankingRLModel.dart';

import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';

part 'list_sl_event.dart';
part 'list_sl_state.dart';

final service_api = ServiceAPIsSlot();
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListSlotBloc extends Bloc<ListSlEvent, ListSLState> {
  final http.Client httpClient;
  ListSlotBloc({required this.httpClient}) : super(const ListSLState()){
    on<ListSlotFetch>(
      _onListFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }

  Future<void> _onListFetched(ListSlotFetch event,Emitter<ListSLState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ListSLStatus.initial) {
        final posts = await service_api.fetchRankingSlot();
        return emit(
          state.copyWith(
            status: ListSLStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await service_api.fetchRankingSlot(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ListSLStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      emit(state.copyWith(status: ListSLStatus.failure));
    }
  }

}
