import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/page/history/history_tab.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/rankingrlpage.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/toprankpage.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/viewpage.dart';
import 'package:tnm_app_slot_aft/service/service_socket_rl.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

class RankingRlTab extends StatefulWidget {

  SocketManagerRL? mySocket;
  RankingRlTab({required this.mySocket, super.key});

  @override
  _RankingRlTabState createState() => _RankingRlTabState();
}

class _RankingRlTabState extends State<RankingRlTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + kTextTabBarHeight),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: MyColor.appBar,
              ),
              child: Stack(
                children: [
                  SafeArea(
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: MyColor.white,
                      indicatorWeight: MyString.padding02,
                      labelColor: MyColor.white,
                      unselectedLabelColor: Colors.white60,
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      tabs: const [
                        Tab(text: "Real Time",),
                        Tab(text: "Top Ranking"),
                        Tab(text: "View"),
                        Tab(text: "History"),
                      ],
                    ),
                  ),
                  Positioned(
                    top:((kToolbarHeight + kTextTabBarHeight)/1.85),left:0,
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_ios_rounded))),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe gesture
        children: [
          RankingRLPage(mySocket:widget.mySocket),
          TopRankingPage(mySocket: widget.mySocket,),
          ViewPage(mySocket: widget.mySocket,),
          const HistoryTab(),
        ],
      ),
    );
  }
}
