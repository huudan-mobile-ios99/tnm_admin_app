import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/top/toprankpagelist.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/service/service_socket_rl.dart';


// ignore: must_be_immutable
class TopRankingPage extends StatefulWidget {

  SocketManagerRL? mySocket;
  TopRankingPage({required this.mySocket, super.key});

  @override
  State<TopRankingPage> createState() => _TopRankingPageState();
}

class _TopRankingPageState extends State<TopRankingPage> {
  final TextEditingController controllerMember = TextEditingController();
  final TextEditingController controllerMC = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final serviceAPIs = ServiceAPIsRL();
  late Future<ListStationModel?> _futureData;


  @override
  void initState() {
    debugPrint('initState top ranking page rl');
    super.initState();
    _futureData = serviceAPIs.listStationDataRL();
  }

  Future<void> refreshData() async {
    setState(() {
      _futureData = serviceAPIs.listStationDataRL();
    });
  }

  @override
  void dispose() {
    debugPrint("dispose rankingpage rl");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
    Scaffold(
        body:Container(
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          child: const ListRankingRLPage())
    );
  }
}
