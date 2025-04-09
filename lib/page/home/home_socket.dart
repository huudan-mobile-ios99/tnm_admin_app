import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_state.dart';
import 'package:tnm_app_slot_aft/page/home/home_jp.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

class HomeSocketPage extends StatefulWidget {
   const HomeSocketPage({super.key});

  @override
  State<HomeSocketPage> createState() => _HomeSocketPageState();
}

class _HomeSocketPageState extends State<HomeSocketPage> {
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
    double widthItem  = width/1.25;
    double widthItemMain  = width/1.25;
    const double heighItem = 135.0;
    const double heighText = 85.0;
    final DateFormatter format = DateFormatter();

    return BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state) {
          return Container(
            width: widthItemMain,
            alignment:Alignment.center,
            height:heighItem+heighText,

            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: SocketManagerSlot().dataStreamJackpotDrop,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child:  CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return textcustom(text: 'error ${snapshot.error}');
                }
                if (snapshot.data!.isEmpty ||
                    snapshot.data == null ||
                    snapshot.data == []) {
                    return const Center(child: Icon(Icons.do_not_disturb_alt_sharp));
                }


                  final dynamic data = snapshot.data;
                  late final String name = data[0]['name'];
                  // late final double jackpotValue = data[0]['value'];
                  late final int jackpotValue = data[0]['value'].round();
                  late final int machineId = data[0]['machineId'] ?? 0;
                  late final int count = data[0]['count'];
                  late final String createdAtv = format.formatDateShortStandar(DateTime.parse(data[0]['createdAt'])) ;

                    // Save data to Bloc
                  context.read<HomeBloc>().saveJackpotData(
                        jackpotValue: jackpotValue,
                        machineId: machineId,
                        createdAt: createdAtv,
                  );

                return
                HomeJPPage(
                  dropValue: "$jackpotValue",
                  jpNameSpace: "JP\nVegas",
                  dateTime: createdAtv,
                  machineNumber: machineId,
                  borderRadius: MyString.padding16, jpName: "",
                  width: widthItem,
                  widthJP:widthItem/2,
                  lastestValue: jackpotValue,
                  height: heighItem*2,
                  asset: "asset/eclip.png",
                  title: "VEGAS\nJP",
                  textSize: MyString.padding64,
                );
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Container(
                //       alignment:Alignment.center,
                //       width: widthItem,
                //       height:heighText,
                //       child:Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //            textcustom(text:'VEGAS JP',size:MyString.padding18),
                //            textcustom(text:'${createdAtv}',size:MyString.padding18),
                //         ],
                //       ),
                //     ),

                //     Container(
                //       width:widthItem,
                //       height:heighItem,
                //       alignment:Alignment.center,
                //       decoration:BoxDecoration(
                //          color:Colors.black,
                //          borderRadius: BorderRadius.circular(MyString.padding16)
                //       ),
                //       child: Align(
                //           alignment: Alignment.center,
                //           child: textcustomColor(text:"\$$jackpotValue  #$machineId",color:MyColor.white,size:MyString.padding64)),
                //     ),
                //   ],
                // );
              },
            ),
          );
        }
    );
  }


}
