
import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/roundModel.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/functions.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class HistoryTopRankingPage extends StatefulWidget {
  const HistoryTopRankingPage({super.key});

  @override
  State<HistoryTopRankingPage> createState() => _HistoryTopRankingPageState();
}

class _HistoryTopRankingPageState extends State<HistoryTopRankingPage> {
  final TextEditingController controllerName = TextEditingController(text: '');
  final TextEditingController controllerNumber =
      TextEditingController(text: '');
  final TextEditingController controllerPoint =
      TextEditingController(text: '0');
  GlobalKey<RefreshIndicatorState> refreshKey =GlobalKey<RefreshIndicatorState>();
  final DateFormatter formatString = DateFormatter();
  Future<void> _refreshData() async {
    setState(() {});
  }


  @override
  void initState() {
    debugPrint('INIT HistoryPageTop');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final service_api = ServiceAPIsRL();
  final TextEditingController controllerLimit =  TextEditingController(text: MyString.DEFAULT_COLUMN);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: MyString.padding16, vertical: MyString.padding04),
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
                future: service_api.listRoundTopRankingRL(),
                builder: (BuildContext context,
                    AsyncSnapshot<RoundModel?> snapshot) {
                  late RoundModel model = snapshot.data as RoundModel;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('An error orcur ${snapshot.error}');
                  } else if (model.data.isEmpty) {
                    return textcustom(text: "No rounds found");
                  }

                  return RefreshIndicator(
                    key: refreshKey,
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(4.0),
                      itemCount: model.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                              color: MyColor.white,
                              border: Border.all(
                                  color: MyColor.grey_tab, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: ListTile(

                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            textcustom(text: '${index + 1}. ${model.data[index].name.toUpperCase()}',size: MyString.padding16),
                                            textcustomColor(color:Colors.black38, text: formatString.formatDateAndTimeFirst(model.data[index].createdAt.toLocal()),size:MyString.padding14),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: textcustom(text: "CANCEL"))
                                        ],
                                        content: SizedBox(
                                          height: height / 2,
                                          width: width ,
                                          child: model.data[index].rankings.isEmpty || snapshot.data == null
                                              ? textcustom(
                                                  text: "no details found")
                                              : ListView.builder(
                                                  shrinkWrap: false,
                                                  itemCount: model.data[index].rankings.length ?? 0,
                                                  physics:const AlwaysScrollableScrollPhysics(),
                                                  itemBuilder: (context, i) =>
                                                    Card(
                                                    child: ListTile(
                                                      title: Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment:CrossAxisAlignment .center,
                                                        mainAxisSize:MainAxisSize.max,
                                                        children: [
                                                          textcustomIcon(
                                                              icon:Icons.person,
                                                              text:"${model.data[index].rankings[i].customerName}",
                                                              color: MyColor.black_text,
                                                              size: MyString.padding16),
                                                          textcustomIcon(
                                                              icon: Icons.attach_money,
                                                              text: formatNumberWithCommas(model.data[index].rankings[i].point as double).toString(),
                                                              color: MyColor .orange_accent,
                                                              size: MyString.padding16),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      )));
                            },
                            leading: Text(
                              '${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            contentPadding:const EdgeInsets.symmetric(horizontal: 8.0),
                            style: ListTileStyle.drawer,
                            dense: true,
                            visualDensity:VisualDensity.adaptivePlatformDensity,
                            selectedColor: MyColor.white,
                            title: textcustom(
                                text: model.data[index].name,
                                size: MyString.padding16,
                                isBold: true),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textcustom(
                                    text: formatString.formatDateAndTimeFirst(model.data[index].createdAt.toLocal()),
                                    size: MyString.padding16),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }
}
