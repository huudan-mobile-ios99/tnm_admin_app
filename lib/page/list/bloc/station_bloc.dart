import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import '../../../service/service_api_slot.dart';
import 'package:stream_transform/stream_transform.dart' as streamTransform;
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'station_event.dart';
part 'station_state.dart';

final ServiceAPIsSlot service_api = ServiceAPIsSlot();
const throttleDuration = Duration(milliseconds: 200);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class StationBloc extends Bloc<StationEvent, StationState> {

  final http.Client httpClient;
  late final StreamSubscription _tickerSubscription;
  StationBloc({required this.httpClient}) : super(const StationState()){

    on<StationFetched>(
      _onListFetched,
      transformer: throttleDroppable(throttleDuration)
    );

  }

  Future<void> _onListFetched(StationFetched event, Emitter<StationState> emit) async {
  debugPrint('_onListFetched called');
    if (state.hasReachedMax) {
      debugPrint('No more data to fetch, reached max.');
      return;
    }


    try {
      if (state.status == StationStatus.initial) {
      // Initial load
      debugPrint('Fetching initial posts...');
      final posts = await service_api.listStationDataSlot();
      if(posts!.list.isEmpty){
        return emit(
        state.copyWith(
          status: StationStatus.failure,
          hasReachedMax: true,
        ),
      );
      }
      return emit(
        state.copyWith(
          status: StationStatus.success,
          posts: posts,
          hasReachedMax: false,
        ),
      );
      }
      // Fetch more posts
      // debugPrint('Fetching more posts...');
      // final additionalPosts = await service_api.listStationData();
      // if (additionalPosts != null && additionalPosts.list.isNotEmpty) {
      //   emit(
      //     state.copyWith(
      //       status: StationStatus.success,
      //       posts: ListStationModel(
      //         list: List.of(state.posts!.list)..addAll(additionalPosts.list),
      //       ),
      //       hasReachedMax: false,
      //     ),
      //   );
      //   debugPrint('New data added: total posts count = ${state.posts!.list.length}');
      // } else {
      //   emit(
      //     state.copyWith(
      //       status: StationStatus.failure,
      //       posts: ListStationModel(
      //         list: [],
      //       ),
      //       hasReachedMax: true,
      //     ),

      //     );
      //   debugPrint('No additional data fetched, reached max.');
      // }
      } catch (e, stackTrade) {
        debugPrint('Error fetching posts: $e');
        debugPrint('StackTrade: $stackTrade');
        emit(state.copyWith(status: StationStatus.failure));
      }
}

}



