import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/page/jackpot/dialog.confirm.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_hive_api.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/util/string_custom_rl.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';



// ignore: must_be_immutable
class ConfigPage extends StatefulWidget {
  // SocketManager? mySocket;
  // ConfigPage({required this.mySocket, super.key});
  const ConfigPage({super.key});


  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {

    //Setting JP VEGAS
  TextEditingController controllerSLot = TextEditingController(text: MyString.BASE_SLOT);
  TextEditingController controllerRL= TextEditingController(text: MyAPIStringRL.BASE_RL);
  TextEditingController controllerRLSocket= TextEditingController(text: MyAPIStringRL.BASEURL_WEBSOCKET_RL);
  TextEditingController controllerSlotSocket= TextEditingController(text: MyString.BASEURL_WEBSOCKET_SLOT);

  final serviceAPIsSlot = ServiceAPIsSlot();
  final serviceAPIsRL = ServiceAPIsRL();
  final formatNumber = DateFormatter();


@override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    debugPrint("dispose config page");
    super.dispose();
  }

  @override
  void initState() {
    loadAPIConfig();
    super.initState();
  }



void loadAPIConfig() {
  final config = HiveAPIConfigService.getAPIConfig();
  if (config != null) {
    controllerRL.text = config.rlEndpoint;
    controllerSLot.text = config.slotEndpoint;
    controllerRLSocket.text = config.rlEndpointSocket;
    controllerSlotSocket.text= config.slotEndpointSocket;
  }
}

void updateAPIConfig() {
  HiveAPIConfigService.saveAPIConfig(rlEndpoint:  controllerRL.text, slotEndpoint:  controllerSLot.text, rlEndpointSocket: controllerRLSocket.text,slotEndpointSocket: controllerSlotSocket.text);
  debugPrint("Updated API Config: RL=${controllerRL.text}${controllerRLSocket.text}, Slot=${controllerSLot.text}${controllerSlotSocket.text}");
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
        body:  Container(
          width:width,
          height:height,
          padding: const EdgeInsets.symmetric(vertical: MyString.padding08,horizontal:MyString.padding08),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("API Endpoint"),
              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "RL Endpoint",
                  text: controllerRL.text,
                  controller: controllerRL,
                  enable: true,
                  textinputType: TextInputType.number),
              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "Slot Enpoint",
                  text: controllerSLot.text,
                  controller: controllerSLot,
                  enable: true,
                  textinputType: TextInputType.number),

              const Text("Web Socket Endpoint"),
              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "RL Endpoint Socket",
                  text: controllerRLSocket.text,
                  controller: controllerRLSocket,
                  enable: true,
                  textinputType: TextInputType.number),
              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "Slot Enpoint Socket",
                  text: controllerSlotSocket.text,
                  controller: controllerSlotSocket,
                  enable: true,
                  textinputType: TextInputType.number),
              const SizedBox(
                height: MyString.padding16,
              ),

              ElevatedButton.icon(
                              iconAlignment: IconAlignment.start,
                              onPressed: () {
                                showConfirmationDialog(context,"Update Setting API Config", () {
                                  debugPrint("showConfirmationDialog Update Setting API Config");
                                  debugPrint("controllerSLot value: ${controllerSLot.text}");
                                  debugPrint("controllerRL value: ${controllerRL.text}");
                                    updateAPIConfig();
                                    showSnackBar(context:context,message:"Update Jackpot Setting");
                                });
                              },
                  label: const Text("Update API Setting"),
                  icon: const Icon(Icons.settings_outlined),
              ),

            ],
          )
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

