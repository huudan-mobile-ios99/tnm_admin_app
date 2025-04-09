import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/service/service_socket_rl.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/loader_dialog.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


// ignore: must_be_immutable
class ViewPage extends StatefulWidget {

  SocketManagerRL? mySocket;
  ViewPage({required this.mySocket, super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final TextEditingController controllerMember = TextEditingController();
  final TextEditingController controllerMC = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final serviceAPIs = ServiceAPIsRL();


  @override
  void initState() {
    debugPrint('initState view page');
    super.initState();
  }

  Future<void> refreshData() async {
    setState(() {

    });
  }

  @override
  void dispose() {
    debugPrint("dispose viewpage rl");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
    Container(
          width: width,
          height: height,
          alignment: Alignment.topCenter,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
    ElevatedButton.icon(
        label: const Text("Reset Top Ranking"),
        icon:const Icon(Icons.reset_tv,),
        onPressed: () {
            debugPrint('reset round');
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
                    serviceAPIs.deleteRankingAllAndAddDefaultRL().then((value) {
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

    ElevatedButton.icon(
        label:const Text("Add Round"),
        icon:const Icon(Icons.add,),
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
                    serviceAPIs.addRealTimeRankingRL().then((value) {
                      showSnackBar(
                          context: context, message: value['message']);
                      serviceAPIs.createRoundRL();
                      serviceAPIs.createRoundRealTimeRL();
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


      ElevatedButton.icon(
          label:const Text("Refresh View"),
          icon:const Icon(Icons.refresh_sharp,),
          onPressed: () {
            debugPrint('refresh data');
            showDialog(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(Icons.refresh_outlined, color: MyColor.pinkMain),
              title: textcustom(text: "Re-Build Top Ranking RL"),
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
          ));

  }
}


