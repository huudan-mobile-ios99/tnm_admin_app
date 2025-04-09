



import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/roundModelRealtime.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/functions.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class HistoryRealTimePage extends StatefulWidget {
  const HistoryRealTimePage({super.key});

  @override
  State<HistoryRealTimePage> createState() => _HistoryRealTimePageState();
}

class _HistoryRealTimePageState extends State<HistoryRealTimePage> {
  final TextEditingController controllerName = TextEditingController(text: '');
  final TextEditingController controllerNumber =
      TextEditingController(text: '');
  final TextEditingController controllerPoint =
      TextEditingController(text: '0');
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final DateFormatter formatString = DateFormatter();
  Future<void> _refreshData() async {
    setState(() {});
  }



  @override
  void initState() {
    debugPrint('INIT HistoryPageRealTime');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ServiceAPIsRL service_api = ServiceAPIsRL();
  final TextEditingController controllerLimit =
      TextEditingController(text: MyString.DEFAULT_COLUMN);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            color: MyColor.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FutureBuilder(
                future: service_api.listRoundRealTimeRL(),
                builder: (BuildContext context,AsyncSnapshot<ListRoundRealTimeModel?> snapshot) {
                  late final  ListRoundRealTimeModel model = snapshot.data as ListRoundRealTimeModel;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (snapshot.data!.list.isEmpty || snapshot.data == null ) {
                    return textcustom(text: "no rounds realtime found");
                  }
                  else if (snapshot.hasError) {
                    return Text('An error orcur ${snapshot.error}');
                  }

                  return RefreshIndicator(
                    key: refreshKey,
                    onRefresh: _refreshData,
                    child:

                    ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: model.list.length,
                      itemBuilder: (context, index) {
                        RoundRealtimeModel round = model.list[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                              color: MyColor.white,
                              border: Border.all(color: MyColor.grey_tab, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Column(
                                          mainAxisAlignment:MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            textcustom( text: '${index + 1}. ${round.id.toUpperCase()}',size: MyString.padding14),
                                            textcustomColor(color:Colors.black38, text: formatString.formatDateAndTimeFirst(round.createdAt.toLocal()),size: MyString.padding14),
                                          ],
                                        ),
                                        content: SizedBox(
                                          height: height / 2,
                                          width: width,
                                          child: round.items.isEmpty || snapshot.data == null
                                              ? textcustom(
                                                  text: "no details found")
                                              : ListView.builder(
                                                  shrinkWrap: false,
                                                  itemCount: round.items.length ?? 0,
                                                  physics: const AlwaysScrollableScrollPhysics(),
                                                  itemBuilder: (context, i) =>
                                                    Card(
                                                    child: ListTile(
                                                      title: Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize:MainAxisSize.max,
                                                        children: [
                                                          textcustomIcon(
                                                              icon:Icons.person,
                                                              text: "${round.items[i].customerName} ",
                                                              color: MyColor
                                                                  .black_text,
                                                              size: MyString.padding16),
                                                          textcustomIcon(
                                                              icon: Icons.attach_money,
                                                              text: formatNumberWithCommas(round.items[i].point),
                                                              color: MyColor.orange_accent,
                                                              size: MyString.padding16),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: textcustom(text: "CANCEL"))
                                        ],
                                      )));
                            },
                            leading: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            contentPadding:const EdgeInsets.symmetric(horizontal: 8.0),
                            style: ListTileStyle.drawer,
                            dense: true,
                            visualDensity:VisualDensity.adaptivePlatformDensity,
                            selectedColor: MyColor.white,
                            title: textcustom(
                                text: round.id,
                                size: MyString.padding16,
                                isBold: true),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textcustom(
                                    text: formatString.formatDateAndTimeFirst(round.createdAt.toLocal()),
                                    size: MyString.padding16),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
              )
            ],
          )),
    );
  }
}
