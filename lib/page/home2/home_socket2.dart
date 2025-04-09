import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_state.dart';
import 'package:tnm_app_slot_aft/page/home2/home_card.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

class HomeSocketPage2 extends StatefulWidget {
   const HomeSocketPage2({super.key});

  @override
  State<HomeSocketPage2> createState() => _HomeSocketPage2State();
}

class _HomeSocketPage2State extends State<HomeSocketPage2> {
SocketManagerSlot? mySocket = SocketManagerSlot();


  @override
  void initState() {
    mySocket!.initSocket();
    mySocket!.emitJackpotDrop();
    super.initState();
  }

  @override
  void dispose() {
    mySocket!.initSocket();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double widthItem  = width*.9;
    final double widthItemMain  = width*.9;
    const double heighItem = 135.0;
    const double heighText = 85.0;
    final double heightCard = height * .425;
    final DateFormatter format = DateFormatter();

    return BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state) {
          return Container(
            width: widthItemMain,
            alignment:Alignment.center,
            height:heighItem+heighText,

            child: StreamBuilder<List<Map<String, dynamic>>>(

              stream: SocketManagerSlot().dataStreamJackpotDrop.timeout(
                const Duration(seconds: MyString.TIME_OUT), // Set your timeout duration
                onTimeout: (sink) {
                  sink.addError('Timeout: No data received'); // Handle timeout
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child:  CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load data.'),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                          mySocket!.initSocket();
                          mySocket!.emitJackpotDrop();
                        },
                      label: const Text('Retry'),
                    ),
                  ],
                );

                }
                if (snapshot.data!.isEmpty ||
                    snapshot.data == null ||
                    snapshot.data == []) {
                    return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
                }

                  final dynamic data = snapshot.data;
                  late final int jackpotValue = data[0]['value'].round();
                  late final int machineId = data[0]['machineId'] ?? 0;
                  late final String createdAtv = format.formatDateShortStandar(DateTime.parse(data[0]['createdAt'])) ;

                  // Save data to Bloc
                context.read<HomeBloc>().saveJackpotData(
                      jackpotValue: jackpotValue,
                      machineId: machineId,
                      createdAt: createdAtv,
                );

                return card(
                  value:'$jackpotValue',
                  machine:'$machineId',
                  width: width * 0.875,
                  height: heightCard * 0.5,
                  onPressInfo: (){
                    debugPrint('click for mor info');
                  // showDialog(
                  // context: context,
                  //     builder: (context) => AlertDialog(
                  //         title:Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   textcustom(text: "JP Details",size:MyString.padding18,isBold: true),
                  //                   const Divider(),
                  //                 ],
                  //               ),
                  //         actions: [
                  //           detailJackpot(
                  //             context:context,
                  //             amount : 100,
                  //             machine: 1,
                  //             status:false,
                  //             datetime: "2024/01/01",
                  //             width: width,
                  //           )
                  //         ],
                  //       ),
                // );
                }
                );
              },
            ),
          );
        }
    );
  }


}


Widget customRowCenter(List<Widget> children){
  return Container(
    padding: const EdgeInsets.symmetric(vertical:MyString.padding04,horizontal:MyString.padding08),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(MyString.padding08)
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: children
    ),
  );
}


Widget detailJackpot({
  required bool status,
  required String datetime,
  required BuildContext? context,required int? amount, required int? machine, required double width }){
  return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                customRowCenter([
                                  textcustom(text: "Amout",size:MyString.padding16),
                                  textcustom(text: "100",size:MyString.padding16),
                                ]),
                                customRowCenter([
                                  textcustom(text: "Machine",size:MyString.padding16),
                                  textcustom(text: "#1",size:MyString.padding16),
                                ]),
                                customRowCenter([
                                  textcustom(text: "Status",size:MyString.padding16),
                                  Container(
                                    padding: const EdgeInsets.all(MyString.padding04),
                                    decoration:BoxDecoration(
                                      color:status ==false ? MyColor.green:  MyColor.yellowMain,
                                      borderRadius: BorderRadius.circular(MyString.padding04)
                                    ),
                                    child: textcustomColor(text:status == false ? "Finished" : "Playing",
                                    size:MyString.padding14,
                                    isBold: true,
                                    color:Colors.white)),
                                ]),
                                customRowCenter([
                                  textcustom(text: "Date Time ",size:MyString.padding16),
                                  textcustom(text: datetime,size:MyString.padding16),
                                ]),
                                const SizedBox(height:MyString.padding16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  const SizedBox(),
                                  customButtonIcon(
                                    width:width / 3,
                                    textSize: MyString.padding16,
                                    icon:const Icon(Icons.close_rounded,color:MyColor.red),
                                    text:"CANCEL",
                                    onTap: (){
                                      debugPrint("click cancel jp detail");
                                      Navigator.of(context!).pop();
                                    },
                                  ),
                                  ],
                                ),
                              ],
                            );
}
