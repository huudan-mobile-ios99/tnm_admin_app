import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import 'package:tnm_app_slot_aft/page/jackpot/bloc_setting/settting_bloc.dart';
import 'package:tnm_app_slot_aft/page/jackpot/dialog.confirm.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';
import 'package:http/http.dart' as http;



// ignore: must_be_immutable
class JackpotPage extends StatefulWidget {
  SocketManagerSlot? mySocket;
  JackpotPage({required this.mySocket, super.key});


  @override
  State<JackpotPage> createState() => _JackpotPageState();
}

class _JackpotPageState extends State<JackpotPage> {

    //Setting JP VEGAS
  TextEditingController controllerJPMin = TextEditingController(text: '${MyString.JPPriceMin}');
  TextEditingController controllerJPMax = TextEditingController(text: "${MyString.JPPriceMax}");
  TextEditingController controllerJPPercent = TextEditingController(text: "${MyString.JPPricePercent}");
  TextEditingController controllerJPThreshold =TextEditingController(text: "${MyString.JPPriceThresHold}");
  TextEditingController controllerJPduration =TextEditingController(text: "${MyString.JPThrotDuration}");
  final serviceAPIs = ServiceAPIsSlot();
  late Future<ListStationModel?> _futureData;
  final formatNumber = DateFormatter();


  Future<void> refreshData() async {
    setState(() {

    });
  }



@override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    debugPrint("dispose jackpot page");
    super.dispose();
  }

  void _setControllerValues(SettingState state) {

  }

  @override
  void initState() {
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
          title: textcustomColor(text:'Jackpot Setting',size:MyString.padding16,color:MyColor.white,isBold: true),
          actions: const [

          ],
        ),
        body:  BlocProvider(
          create: (_) =>SetttingBloc(httpClient: http.Client())..add(SettingFetched()),
          child: Container(
            width:width,
            height:height,
            padding: const EdgeInsets.symmetric(vertical: MyString.padding08,horizontal:MyString.padding08),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                mytextFieldTitleSizeIcon(
                    width: width,
                    icon:const Icon(Icons.attach_money_outlined),
                    label: "Min JP",
                    text: controllerJPMin.text,
                    controller: controllerJPMin,
                    enable: true,
                    textinputType: TextInputType.number),
                const SizedBox(
                  width: MyString.padding08,
                ),
                mytextFieldTitleSizeIcon(
                    width: width,
                    icon:const Icon(Icons.attach_money_outlined),
                    label: "Max JP",
                    text: controllerJPMax.text,
                    controller: controllerJPMax,
                    enable: true,
                    textinputType: TextInputType.number),
                const SizedBox(
                  width: MyString.padding08,
                ),
                mytextFieldTitleSizeIcon(
                    width: width,
                    icon: const Icon(Icons.attach_money_outlined),
                    label: "Threshold JP",
                    text: controllerJPThreshold.text,
                    controller: controllerJPThreshold,
                    enable: true,
                    textinputType: TextInputType.number),
                const SizedBox(
                  width: MyString.padding08,
                ),
                mytextFieldTitleSizeIcon(
                    width: width,
                    icon: const Icon(Icons.percent),
                    label: "Percent JP",
                    text: controllerJPPercent.text,
                    controller: controllerJPPercent,
                    enable: true,
                    textinputType: TextInputType.number),
                const SizedBox(
                  width: MyString.padding08,
                ),
                mytextFieldTitleSizeIcon(
                    width: width,
                    icon: const Icon(Icons.timer),
                    label: "Duration(second)",
                    text: controllerJPduration.text,
                    controller: controllerJPduration,
                    enable: false,
                    textinputType: TextInputType.number),
                const SizedBox(
                  height: MyString.padding16,
                ),
                Tooltip(
                                    message: "Display JP in client view",
                                    child: ElevatedButton.icon(
                                        label: const Text("Display & View JP"),
                                        onPressed: () {
                                          showConfirmationDialog(context,"Display View & Reset JP (vegas prize)",
                                            () {
                                            widget.mySocket!.emitJackpotNumberInit();
                                          });
                                        },
                                        icon: const Icon(Icons.airplay_rounded)),
                ),

                const SizedBox(
                  height: MyString.padding16,
                ),

                ElevatedButton.icon(
                                iconAlignment: IconAlignment.start,
                                onPressed: () {
                                  showConfirmationDialog(context,"Update Setting JP (Vegas Prize)", () {
                                    debugPrint("showConfirmationDialog JP");
                                    debugPrint("Percent value: ${controllerJPPercent.text}");
                                    debugPrint("Min value: ${controllerJPMin.text}");
                                    debugPrint("Max value: ${controllerJPMax.text}");
                                    debugPrint("defaultThreshold value: ${controllerJPThreshold.text}");
                                    debugPrint("duration value: ${controllerJPduration.text}");

                                    Map<String, dynamic> newSettings = {
                                      "oldValue":double.parse(controllerJPMin.text),
                                      "returnValue": double.parse(controllerJPMin.text), // Example of updating just one or more fields
                                      "limit": double.parse(controllerJPMax.text),
                                      "defaultThreshold": double.parse( controllerJPThreshold.text),
                                      "throttleInterval": double.parse(controllerJPduration.text),
                                      "percent":double.parse(controllerJPPercent.text)
                                    };
                                    validateInput(
                                                percent: controllerJPPercent.text,
                                                min: controllerJPMin.text,
                                                max: controllerJPMax.text,
                                                threshold: controllerJPThreshold.text) == true
                                        ? {
                                            widget.mySocket!.updateJackpotSettings( newSettings),
                                            showSnackBar(
                                                context: context,
                                                message: "Setting JP Update")
                                          }
                                        : showSnackBarError(
                                            context: context,
                                            message:"Setting JP Not Update, Invalid Fields");
                                  });
                                },
                                label: const Text("Update Setting"),
                                icon: const Icon(Icons.settings_outlined),
                ),

              ],
            )
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






Future<void> showConfirmationDialog(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return ConfirmationDialogWidget(
        actionTitle: actionTitle,
        onConfirmed: onConfirmed,

      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}
