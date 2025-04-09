import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/list/bloc/station_bloc.dart';
import 'package:tnm_app_slot_aft/page/list/station_item.dart';
import 'package:tnm_app_slot_aft/page/list/station_item_title.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/loading_indicator.dart';




// ignore: must_be_immutable
class StationListPage extends StatefulWidget {
  const StationListPage({super.key});

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  Timer? _debounce;
  @override
  void initState() {
    debugPrint('initState StationListPage');
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (_isBottom) {
        debugPrint('Debounced: reach bottom station_list_page.dart');
        context.read<StationBloc>().add(StationFetched());
      }
    });
  }

  void _onRefresh() {
    context.read<StationBloc>().add(StationFetched());
    context.read<StationBloc>().emit(const StationState());
  }

  final ServiceAPIsSlot service_api = ServiceAPIsSlot();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        switch (state.status) {
          case StationStatus.failure:
            return Center(
              child: TextButton.icon(
              icon: const Icon(Icons.refresh),
              onPressed: _onRefresh,
              label: const Text('No JP history founds, press to retry'),
            ));
          case StationStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case StationStatus.success:
            if (state.posts!.list.isEmpty || state.posts == null) {
              return const Text('No station found');
            }
            if (state.posts == null ) {
            return const Center(child: Text( 'No station found', ),);
            }
            return Column(
              children: [
                 StationItemTitle(
                  onRefresh: (){
                    _onRefresh();
                  },
                 ),
                Expanded(
                  child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.hasReachedMax
                      ? state.posts!.list.length // No loader if max is reached
                      : state.posts!.list.length +
                          1, // Add an extra slot for loader
                  itemBuilder: (context, index) {
                    return index >= state.posts!.list.length
                        ? SizedBox(
                            height: MyString.padding28,
                            width: width,
                            child: loadingIndicatorSize())
                        : StationItem(
                            post: state.posts!.list[index],
                            index: index,
                            onPressView: (){
                              debugPrint("onPress View $index ${state.posts!.list[index]}");
                            },
                            onPressEdit: () {
                              debugPrint('onPressEdit $index ${state.posts!.list[index]}  ${state.posts!.list[index]}');
                            },
                            onPressDelete: () {
                              debugPrint('onPressDelete ${state.posts!.list[index]}');
                            },
                          );
                  },
                ))
              ],
            );
        }
      },
    );
  }

  //is bottom
  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }
}
