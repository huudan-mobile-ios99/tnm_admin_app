import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import 'package:tnm_app_slot_aft/page/ranking/ranking_top_pagelist.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/loader_dialog.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


// ignore: must_be_immutable
class RankingTopPage extends StatefulWidget {

  SocketManagerSlot? mySocket;
  RankingTopPage({required this.mySocket, super.key});

  @override
  State<RankingTopPage> createState() => _RankingTopPageState();
}

class _RankingTopPageState extends State<RankingTopPage> {
  final TextEditingController controllerMember = TextEditingController();
  final TextEditingController controllerMC = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final serviceAPIs = ServiceAPIsSlot();
  late Future<ListStationModel?> _futureData;


  @override
  void initState() {
    debugPrint('initState ranking top page slot');
    super.initState();
    _futureData = serviceAPIs.listStationDataSlot();
  }

  Future<void> refreshData() async {
    setState(() {
      _futureData = serviceAPIs.listStationDataSlot();
    });
  }

  @override
  void dispose() {
    debugPrint("dispose ranking top page slot");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          backgroundColor: MyColor.appBar,
          title: textcustomColor(text:'Ranking Top',size:MyString.padding16,color:MyColor.white,isBold: true),
          actions: [
        TextButton(
        child:const Icon(Icons.reset_tv,color:Colors.white),
        onPressed: () {
            debugPrint('reset round slot');
            showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.reset_tv, color: MyColor.pinkMain),
            title: textcustom(text: "Reset Top Ranking",size: MyString.padding18),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textcustom(text: "Reset top ranking will be make top ranking as default  if you click confirm")
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('CANCEL'),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, color: MyColor.red),
                onPressed: () async {
                  debugPrint('data reset round');
                  showLoaderDialog(context);
                  try {
                    serviceAPIs.deleteRankingAllAndAddDefault().then((value) {
                      showSnackBar(
                      context: context, message: value['message']);
                    }).whenComplete(() {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } catch (e) {
                    debugPrint('error when reset round $e');
                    Navigator.of(context).pop();
                  }
                },
                label: const Text('CONFIRM'),
              ),
            ],
          ));
        },
      ),
    const SizedBox(height: MyString.padding24,),

    TextButton(
        child:const Icon(Icons.add,color:Colors.white),
        onPressed: () {
            debugPrint('add round');
            showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.add, color: MyColor.pinkMain),
            title: textcustom(text: "ADD ROUND",size: MyString.padding18),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textcustom(text: "Add round from realtime data to top ranking will be take action if you click confirm\nthese action will be process:\n-create new data for top ranking\n-save history top ranking\n-save history realtime\n\nPlease make sure before click confirm button")
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('CANCEL'),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, color: MyColor.red),
                onPressed: () async {
                  debugPrint('data create round');
                  showLoaderDialog(context);
                  try {
                    serviceAPIs.addRealTimeRanking().then((value) {
                      showSnackBar(
                          context: context, message: value['message']);
                      serviceAPIs.createRound();
                      serviceAPIs.createRoundRealTime();
                    }).whenComplete(() {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } catch (e) {
                    debugPrint('error when add round $e');
                    Navigator.of(context).pop();
                  }
                },
                label: const Text('CONFIRM'),
              ),
            ],
          ));
        },
      ),

      const SizedBox(height: MyString.padding24,),

            TextButton.icon(
                label:const SizedBox(),
                icon:const Icon(Icons.refresh_sharp,color:MyColor.white),
                onPressed: () {
                  debugPrint('refresh data');
                  showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(Icons.refresh_outlined, color: MyColor.pinkMain),
                    title: textcustom(text: "Re-Build Top Ranking Slot"),
                    content: textcustom(
                        text:"Re-Build top ranking will be take action if you click confirm\n-data will be latest\n-animation will run\n-all devices will be re-build UI\n\nPlease make sure before click confirm button"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("CANCEL")),
                      TextButton.icon(
                          icon: const Icon(Icons.add, color: MyColor.red),
                          onPressed: () {
                            showLoaderDialog(context);
                            widget.mySocket!.emitEventFromClient2Force().then((value){
                              Navigator.of(context).pop();
                            });
                            Navigator.of(context).pop();
                          },
                          label: const Text("CONFIRM")),
                    ],
                  ),
                );
                },
            ),

          ],
        ),
        body:  const ListRankingSlotPage()

        );
  }
}


