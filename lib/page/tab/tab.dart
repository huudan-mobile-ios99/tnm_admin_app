import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tnm_app_slot_aft/page/history/jackpot_page.dart';
import 'package:tnm_app_slot_aft/page/home/home.dart';
import 'package:tnm_app_slot_aft/page/list/station_page.dart';
import 'package:tnm_app_slot_aft/page/tab/tab_bloc.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TNM SLOT AFT',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/background_main.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                return TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  isScrollable: false,
                  onTap: (index) {
                    tabBloc.add(TabChangedEvent(index));
                  },
                  tabs: const [
                    Tab(text: 'AFT'),
                    Tab(text: 'LIST'),
                    Tab(text: 'HISTORY'),
                  ],
                  labelStyle: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: MyString.padding18,
                  ),
                  unselectedLabelStyle: GoogleFonts.inter(
                    color: Colors.white70,
                  ),
                  indicatorWeight: 4.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                );
              },
            ),
          ),
        ),
        body: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            return const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                ListPage(),
                JackpotHistoryPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
