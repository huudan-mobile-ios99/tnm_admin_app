
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/top/bloc/list_rl_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tnm_app_slot_aft/page/ranking_rl/top/toprankinglist_body.dart';

class ListRankingRLPage extends StatelessWidget {
  const ListRankingRLPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (_) => ListRLBloc(httpClient: http.Client())..add(ListRLFetched()),
        child:  const TopRankingListBody(),
      ),
    );
  }
}
