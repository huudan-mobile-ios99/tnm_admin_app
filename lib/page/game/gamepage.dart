import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/jackpot/bloc_setting/settting_bloc.dart';
import 'package:tnm_app_slot_aft/page/jackpot/dialog.confirm.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';
import 'package:http/http.dart' as http;



// ignore: must_be_immutable
class GamePage extends StatefulWidget {
  SocketManagerSlot? mySocket;
  GamePage({required this.mySocket, super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

   final TextEditingController controllerMinBet = TextEditingController();
  final TextEditingController controllerMaxBet = TextEditingController();
  final TextEditingController controllerTotalRoud = TextEditingController();
  final TextEditingController controllerCurrentRound = TextEditingController();
  final TextEditingController controllerLastUpdate = TextEditingController();
  final TextEditingController controllerBuyIn = TextEditingController();
  final TextEditingController controllerBuyInText = TextEditingController();
  final formatNumber = DateFormatter();



  void _setControllerValues(SettingState state) {
    controllerMinBet.text = '${state.posts.first.minbet}';
    controllerMaxBet.text = '${state.posts.first.maxbet}';
    controllerTotalRoud.text = '${state.posts.first.remaingame}';
    controllerCurrentRound.text = '${state.posts.first.run}';
    controllerBuyIn.text = '${state.posts.first.buyin}';
    controllerLastUpdate.text =formatNumber.formatDateAndTime(state.posts.first.lastupdate);
    controllerBuyInText.text = '${state.posts.first.roundtext}';
  }



@override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    controllerMinBet.dispose();
    controllerMaxBet.dispose();
    controllerTotalRoud.dispose();
    controllerCurrentRound.dispose();
    controllerLastUpdate.dispose();
    controllerBuyIn.dispose();
    controllerBuyInText.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          title: textcustomColor(text:'Game Setting',size:MyString.padding16,color:MyColor.white,isBold: true),
          actions: const [

          ],
        ),
        body:  BlocProvider(
          create: (_) =>SetttingBloc(httpClient: http.Client())..add(SettingFetched()),
          child: BlocListener<SetttingBloc,SettingState>(
            listener: (context, state) {
              if (state.status == SettingStatus.success &&
                  state.posts.isNotEmpty) {
                  _setControllerValues(state);
              }
            },
            child: BlocBuilder<SetttingBloc, SettingState>(
              builder:  (context, state) {
              switch (state.status) {
                  case SettingStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case SettingStatus.failure:
                    return const Center(
                        child: Text('An error orcur when fetch settings'));
                  case SettingStatus.success:
                    if (state.posts.isEmpty) {
                      return const Center(child: Text('No settings found'));
                    }

              return Container(
                width:width,
                height:height,
                padding: const EdgeInsets.symmetric(vertical: MyString.padding08,horizontal:MyString.padding08),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                                    mytextFieldTitleSizeIcon(
                                        width:width,
                                        icon:const Icon(Icons.attach_money_outlined),
                                        label: "Min Bet",
                                        text: controllerMinBet.text,
                                        controller: controllerMinBet,
                                        enable: true,
                                        textinputType: TextInputType.number),
                                    const SizedBox(
                                      width: MyString.padding04,
                                    ),
                                    mytextFieldTitleSizeIcon(
                                        width: width,
                                        icon:const Icon(Icons.attach_money_outlined),
                                        label: "Max Bet",
                                        text: controllerMaxBet.text,
                                        controller: controllerMaxBet,
                                        enable: true,
                                        textinputType: TextInputType.number),
                                    const SizedBox(
                                      width: MyString.padding04,
                                    ),
                                    mytextFieldTitleSizeIcon(
                                        width: width,
                                        icon: const Icon(Icons.attach_money_outlined),
                                        label: "Buy-In (Minutes)",
                                        text: controllerBuyIn.text,
                                        controller: controllerBuyIn,
                                        enable: true,
                                        textinputType: TextInputType.number),
                                    const SizedBox(
                                      width: MyString.padding04,
                                    ),
                                    mytextFieldTitleSizeIcon(
                                        width: width,
                                        icon: const Icon(Icons.lock_clock_rounded),
                                        label: "Buy-In (Text)",
                                        text: controllerBuyInText.text,
                                        controller: controllerBuyInText,
                                        enable: true,
                                        textinputType: TextInputType.number),
                                    mytextFieldTitleSizeIcon(
                                        width: width,
                                        icon: const Icon(Icons.airplay),
                                        label: "Remain Round",
                                        text: controllerTotalRoud.text,
                                        controller: controllerTotalRoud,
                                        enable: true,
                                        textinputType: TextInputType.number),
                                    const SizedBox(
                                      width: MyString.padding08,
                                    ),
                                    mytextFieldTitleSizeIcon(
                                        width: width,
                                        icon: const Icon(Icons.airplay),
                                        label: "Current Round",
                                        text: controllerCurrentRound.text,
                                        controller: controllerCurrentRound,
                                        enable: true,
                                        textinputType: TextInputType.number),

                    const SizedBox(
                      height: MyString.padding16,
                    ),
                    Tooltip(
                                    message: "Display game setting in client view",
                                    child: ElevatedButton.icon(
                                        label: const Text("Dislay & View Game"),
                                        onPressed: () {
                                          showConfirmationDialog(
                                            context, "Dislay & View Game", () {
                                            widget.mySocket!.emitSetting();
                                          });
                                        },
                                        icon: const Icon(Icons.airplay_rounded)),
                    ),

                    const SizedBox(
                      height: MyString.padding16,
                    ),

                    ElevatedButton.icon(
                                  icon: const Icon(Icons.settings_outlined),
                                  onPressed: () {
                                    debugPrint("Update Game Setting ");
                                    showConfirmationDialog(
                                      context,
                                      "Update Game Setting",
                                      () {
                                        // Action when confirmed
                                        debugPrint("Confirmed action executed");
                                        debugPrint("min: ${controllerMinBet.text}");
                                        debugPrint("max: ${controllerMaxBet.text}");
                                        debugPrint("current: ${controllerCurrentRound.text}");
                                        debugPrint("total: ${controllerTotalRoud.text}");
                                        debugPrint("buy in: ${controllerBuyIn.text}");


                                        service_api.updateSetting(
                                                remaintime:'${state.posts.first.remaintime}',
                                                remaingame: int.parse(controllerTotalRoud.text),
                                                minbet: int.parse(controllerMinBet.text),
                                                maxbet: int.parse(controllerMaxBet.text),
                                                run: int.parse(controllerCurrentRound.text),
                                                lastupdate: DateTime.now().toIso8601String(),
                                                gamenumber:state.posts.first.gamenumber!,
                                                roundtext:controllerBuyInText.text,
                                                gametext:state.posts.first.gametext!,
                                                buyin:int.parse(controllerBuyIn.text))
                                            .then((v) {
                                          if (v['status'] == 1) {
                                            showSnackBar(
                                                context: context,
                                                message: "${v['message']}");
                                          } else {
                                            showSnackBar(
                                                context: context,
                                                message: "Can not update setting ");
                                          }
                                        }).whenComplete(() {
                                          debugPrint('complete update APIs');
                                        });
                                      },
                                    );
                                  },
                                  label: const Text("Update  Setting")),
                  ],
                )
              );
          }}),
          ),
        ));
  }
}







bool? validateInput(
    {String? percent, String? min, String? max, String? threshold}) {
  // Check if all inputs are provided and are numbers
  final percentNumber = double.tryParse(percent ?? '');
  final minNumber = double.tryParse(min ?? '');
  final maxNumber = double.tryParse(max ?? '');
  final thresholdNumber = double.tryParse(threshold ?? '');
  // Return false if any input is null or not a number
  if (percentNumber == null ||
      minNumber == null ||
      maxNumber == null ||
      thresholdNumber == null) {
    return false;
  }
  // Validate percent < 1
  if (percentNumber >= MyString.JPPercentMax) {
    return false;
  }
  // Validate min < threshold < max
  if (!(minNumber < thresholdNumber && thresholdNumber < maxNumber)) {
    return false;
  }
  return true; // All validations passed
}




