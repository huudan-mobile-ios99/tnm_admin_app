import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/history/bloc/jackpot_bloc.dart';
import 'package:tnm_app_slot_aft/page/history/jackpot_item.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/loading_indicator.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';




// ignore: must_be_immutable
class JackpotHistoryDropList extends StatefulWidget {
  const JackpotHistoryDropList({super.key});

  @override
  State<JackpotHistoryDropList> createState() => _JackpotHistoryDropListState();
}

class _JackpotHistoryDropListState extends State<JackpotHistoryDropList> {
  Timer? _debounce;
  @override
  void initState() {
    debugPrint('initState JackpotHistoryDropList');
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
        debugPrint('Debounced: reach bottom list.dart');
        context.read<JackpotDropBloc>().add(JackpotDropFetched());
      }
    });
  }

  void _onRefresh() {
    context.read<JackpotDropBloc>().add(JackpotDropFetched());
    context.read<JackpotDropBloc>().emit(const JackpotDropState());
  }

  final ServiceAPIsSlot service_api = ServiceAPIsSlot();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<JackpotDropBloc, JackpotDropState>(
      builder: (context, state) {
        switch (state.status) {
          case JackpotDropStatus.failure:

          return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load data.'),
                  const SizedBox(height: MyString.padding08),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    onPressed: _onRefresh,
                    label: const Text('Retry'),
                  ),
                ],
          );
          case JackpotDropStatus.initial:
            return Center(
              child: SizedBox(
                    height: MyString.padding28,
                    width: width,
                    child: loadingIndicatorSize()),
            );
          case JackpotDropStatus.success:
            if (state.posts!.data.isEmpty || state.posts == null) {
              return const Text('No JP history');
            }
            if (state.posts == null ) {
            return const Center(child: Text( 'No JP history', ),);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:MyString.padding08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  AdminItemTitleJP(
                  //   onRefresh: (){
                  //     _onRefresh();
                  //   },
                  //  ),
                  textcustomCenter(text:"History",isBold: true,size:MyString.padding18,align: TextAlign.left),
                  const SizedBox(height: MyString.padding08,),
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async{
                        _onRefresh();
                      },
                      child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      reverse: false,
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.posts!.data.length // No loader if max is reached
                          : state.posts!.data.length +
                              1, // Add an extra slot for loader
                      itemBuilder: (context, index) {
                        return index >= state.posts!.data.length
                            ? SizedBox(
                                height: MyString.padding28,
                                width: width,
                                child: loadingIndicatorSize())
                            : ItemListViewJP(
                                post: state.posts!.data[index],
                                index: index,
                                onPress: (){
                                  debugPrint('onpress to recall ItemListViewJP jp list page  ${state.posts!.data[index].machineId} ${state.posts!.data[index].value.round()}');
                                  debugPrint('onpress to recall ');
                                  },

                              );
                      },
                                        ),
                    ))
                ],
              ),
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
