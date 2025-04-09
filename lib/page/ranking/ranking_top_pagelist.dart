import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:tnm_app_slot_aft/page/ranking/bloc/list_sl_bloc.dart';
import 'package:tnm_app_slot_aft/page/ranking/ranking_top_pagelistbody.dart';

class ListRankingSlotPage extends StatelessWidget {
  const ListRankingSlotPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (_) => ListSlotBloc(httpClient: http.Client())..add(ListSlotFetch()),
        child:  const RankingTopPageListBody(),
      ),
    );
  }
}
