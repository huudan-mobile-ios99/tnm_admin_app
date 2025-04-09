import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_state.dart';
import 'package:tnm_app_slot_aft/page/home/home_socket.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>HomeBloc(),child:const HomePageBody());
  }
}
class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
    final TextEditingController controllerAFT = TextEditingController();
    // final TextEditingController controllerMember = TextEditingController();
    final TextEditingController controllerIP = TextEditingController();
    final TextEditingController controllerStatus = TextEditingController();


    setValue(HomeState state){
      debugPrint('setValue : ${state.jackpotValue} ${state.machineId}');
      if(state.jackpotValue==0 && state.machineId ==0){
        debugPrint("HomeState state true");
        setState(() {
            controllerIP.text = ""; // Ensure non-null
            controllerAFT.text = ""; // Ensure non-null
      });
      }
      else{
       setState(() {
            controllerIP.text = state.machineId.toString(); // Ensure non-null
            controllerAFT.text = state.jackpotValue.toString(); // Ensure non-null
      });
      }

    }


    bool validateField(){
      // Check if any of the fields are empty or equal to "0"
      if (controllerAFT.text.isEmpty ||
          controllerIP.text.isEmpty ||
          controllerAFT.text == "0" ||
          controllerIP.text == "0") {
        return false;
      }

      // Attempt to parse the text fields into integers
      int? aftValue = int.tryParse(controllerAFT.text);
      int? ipValue = int.tryParse(controllerIP.text);

      // Validate that both fields contain valid integers
      if (aftValue == null || ipValue == null) {
        return false;
      }

      // Check if aftValue exceeds 1000
      if (aftValue > 1000) {
        return false;
      }

      // All validations passed
      return true;
    }




  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;
     double widthItem  = width/1.35;

    final state = context.read<HomeBloc>().getJackpotData();


    return  Container(
        alignment:Alignment.center,
        height:height,
        width:width,
        padding: const  EdgeInsets.all(MyString.padding08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const HomeSocketPage(),

          const SizedBox(height:MyString.padding64),

           mytextFieldTitle(
            width: widthItem,
            controller:controllerIP,
            hint: "IP",
            prefixIcon: const Icon(Icons.computer_outlined),
            enable: true,
            textinputType: TextInputType.text,
            label:"IP"
           ),
           const SizedBox(height:MyString.padding16),
           mytextFieldTitle(
            width: widthItem,
            controller:controllerIP,
            hint: "Member Number",
            enable: true,
            textinputType: TextInputType.text,

            label:"MEMBER",
            prefixIcon: const Icon(Icons.person_4)
           ),
           const SizedBox(height:MyString.padding16),
           mytextFieldTitle(
            width: widthItem,
            controller:controllerAFT,
            hint: "AFT Amount (\$)",
            prefixIcon: const Icon(Icons.attach_money),
            enable: true,
            textinputType: TextInputType.text,
            label:"AFT",
           ),
          //  const SizedBox(height:MyString.padding16),
          //  mytextFieldTitle(
          //   width: widthItem,
          //   controller:controllerStatus,
          //   hint: "STATUS MACHINE",
          //   prefixIcon: Icon(Icons.online_prediction),
          //   enable: false,
          //   textinputType: TextInputType.text,
          //   label:"STATUS",
          //  ),
           const SizedBox(height:MyString.padding32),

           SizedBox(width:widthItem,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: MyColor.grey_tab, // background color
                //     ),
                //     onPressed: () {
                //       validateField() ==true
                //      ? showDialog(
                //                 context: context,
                //                 builder: (context) => AlertDialog(
                //                       title: const Text("Confirm AFT Input"),
                //                       content: textcustom(text: "Are you sure?\nClick 'Confirm' to proceed.\nMachine IP: \$${controllerIP.text}  | JP Value: #${controllerAFT.text}"),
                //                       actions: [
                //                         TextButton(
                //                             onPressed: () {
                //                               Navigator.of(context).pop();
                //                             },
                //                             child: textcustom(text: "CANCEL")),
                //                         TextButton(
                //                             onPressed: () {
                //                               debugPrint('confirm aft input: ip:${controllerIP.text}   aft: ${controllerAFT.text}');
                //                               Navigator.of(context).pop();
                //                             },
                //                             child: textcustom(text: "CONFIRM")),
                //                       ],
                //                     )) : showSnackBar(context:context,message:"Empty or Invalid fields");
                //     },
                //     child: textcustomColor(color:MyColor.black_absolute,size: MyString.padding18,isBold: false,text:"CONFIRM"),
                //   ),
                customButton(width: width/5,text:"CONFIRM",onTap: (){
                  validateField() ==true
                     ? showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Confirm AFT Input"),
                                      content: textcustom(text: "Are you sure?\nClick 'Confirm' to proceed.\nMachine IP: \$${controllerIP.text}  | JP Value: #${controllerAFT.text}"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: textcustom(text: "CANCEL")),
                                        TextButton(
                                            onPressed: () {
                                              debugPrint('confirm aft input: ip:${controllerIP.text}   aft: ${controllerAFT.text}');
                                              Navigator.of(context).pop();
                                            },
                                            child: textcustom(text: "CONFIRM")),
                                      ],
                                    )) : showSnackBar(context:context,message:"Empty or Invalid fields");
                }),
                customButton(width:  width/5,text:"FILL",onTap: (){
                     debugPrint("onPressed Fill");
                     debugPrint("${state.machineId} . ${state.jackpotValue} . ${state.createdAt}");
                     setValue(state);
                }),
                customButton(width:  width/5,text:"CLEAR",onTap: (){
                      debugPrint("onPressed clear");
                      controllerIP.clear();
                      controllerAFT.clear();
                }),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: MyColor.grey_tab, // background color
                //     ),
                //     onPressed: () {
                //       debugPrint("onPressed Fill");
                //       debugPrint("${state.machineId} . ${state.jackpotValue} . ${state.createdAt}");
                //       setValue(state);

                //      },
                //     child: textcustomColor(color:MyColor.black_absolute,size: MyString.padding18,isBold: false,text:"FILL"),
                //   ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: MyColor.grey_tab, // background color
                //     ),
                //     onPressed: () {
                //       debugPrint("onPressed clear");
                //       controllerIP.clear();
                //       controllerAFT.clear();
                //      },
                //     child: textcustomColor(color:MyColor.black_absolute,size: MyString.padding18,isBold: false,text:"CLEAR"),
                // ),
              ],
            )
           ),
          ],
        )
      );
  }
}
