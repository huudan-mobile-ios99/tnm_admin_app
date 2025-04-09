import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/page/history/history_realtime_page.dart';
import 'package:tnm_app_slot_aft/page/history/history_topranking_page.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return   const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: "Realtime Rank"),
              Tab(text: "Top Rank"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                HistoryRealTimePage(),
                HistoryTopRankingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
