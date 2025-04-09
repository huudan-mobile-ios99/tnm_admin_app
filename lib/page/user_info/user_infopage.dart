import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/loginModel.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';



// ignore: must_be_immutable
class UserInfoPage extends StatefulWidget {
  // SocketManager? mySocket;
  // UserInfoPage({required this.mySocket, super.key});

  LoginModel? loginModel;
  UserInfoPage({super.key,required this.loginModel});


  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {


  late TextEditingController controllerUserName ;
  late TextEditingController controllerUserRole ;
  late TextEditingController controllerUserAvatar ;




@override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    debugPrint("dispose user info page");
    super.dispose();
  }

  @override
  void initState() {
    controllerUserName = TextEditingController(text: widget.loginModel?.data.username ?? '');
    controllerUserRole = TextEditingController(text: widget.loginModel?.data.role ?? '');
    controllerUserAvatar = TextEditingController(text: widget.loginModel?.data.imageUrl ?? '');

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
          title: textcustomColor(text:'User Info',size:MyString.padding16,color:MyColor.white,isBold: true),
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

              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "User Name",
                  text: controllerUserName.text,
                  controller: controllerUserName,
                  enable: true,
                  textinputType: TextInputType.number),
              const SizedBox(
                width: MyString.padding08,
              ),
              mytextFieldTitleSizeIcon(
                  width: width,
                  icon:const Icon(Icons.attach_money_outlined),
                  label: "User Role",
                  text: controllerUserRole.text,
                  controller: controllerUserRole,
                  enable: true,
                  textinputType: TextInputType.number),

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

