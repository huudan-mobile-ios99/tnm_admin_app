import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/list/bloc/station_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tnm_app_slot_aft/page/list/station_list_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
       create: (_) => StationBloc(httpClient: http.Client())..add(StationFetched()),
      lazy: false,
      child: Scaffold(
        body: Container(
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            child:const StationListPage(),
           ),
      ),
    );
  }
}
