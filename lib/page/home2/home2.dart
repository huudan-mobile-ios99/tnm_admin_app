import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/game/gamepage.dart';
import 'package:tnm_app_slot_aft/page/history/jackpot_page.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_bloc.dart';
import 'package:tnm_app_slot_aft/page/home/bloc/home_state.dart';
import 'package:tnm_app_slot_aft/page/home2/home_button.dart';
import 'package:tnm_app_slot_aft/page/home2/home_socket2.dart';
import 'package:tnm_app_slot_aft/page/jackpot/jackpotpage.dart';
import 'package:tnm_app_slot_aft/page/ranking/ranking_top_page.dart';
import 'package:tnm_app_slot_aft/page/ranking/rankingpage.dart';
import 'package:tnm_app_slot_aft/page/time/timepage.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

class HomePage2 extends StatefulWidget {
  final SocketManagerSlot mySocket;
  const HomePage2({super.key,required this.mySocket});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeBloc(), child:  HomePage2Body(mySocket: widget.mySocket));
  }
}

class HomePage2Body extends StatefulWidget {
  final SocketManagerSlot mySocket;
  const HomePage2Body({super.key,required this.mySocket});

  @override
  State<HomePage2Body> createState() => _HomePage2BodyState();
}

class _HomePage2BodyState extends State<HomePage2Body> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double heightCard = height * .425;
    const double heightRow = 55.0;
    final state = context.read<HomeBloc>().getJackpotData();
    // Get the jackpot value and machineId from the state
    final int jackpotValue = state.jackpotValue;
    final int machineId = state.machineId;

    return Scaffold(
      drawer: Drawer(
      backgroundColor: MyColor.white,
      elevation: MyString.padding02,
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
           DrawerHeader(
            padding: const EdgeInsets.all(MyString.padding08),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [MyColor.pinkBG2,MyColor.pinkBG])
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white,size: MyString.padding32,),
                    onPressed: () {
                      Navigator.of(context).pop(); // Closes the drawer
                    },
                  ),
                ),
                Center(child: textcustom(text:"TNM Slot Menu",size: MyString.padding22,isBold: true)),
              ],
            )
          ),
          // Card(
          //   child: ListTile(
          //     leading: const Icon(Icons.stacked_bar_chart_outlined),
          //     title:  textcustom(text:"Ranking Member RL", size: MyString.padding16,),
          //     onTap: () {
          //       // Handle drawer item tap
          //       Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //         return  RankingRLPage(mySocket: widget!.mySocket,);
          //       }));

          //     },
          //   ),
          // ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bar_chart_rounded),
              title:  textcustom(text:"Ranking Real Time Slot", size: MyString.padding16,),
              onTap: () {
                // Handle drawer item tap
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return  RankingPage(mySocket: widget.mySocket,);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bar_chart_rounded),
              title:  textcustom(text:"Ranking Top Ranking Slot", size: MyString.padding16,),
              onTap: () {
                // Handle drawer item tap
                debugPrint("ranking top slot");
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return  RankingTopPage(mySocket: widget.mySocket,);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_rounded),
              title:  textcustom(text:"JP Setting", size: MyString.padding16,),
              onTap: () {
                // jackpot item tap
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return JackpotPage(mySocket: widget.mySocket,);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_rounded),
              title:  textcustom(text:"Game Setting", size: MyString.padding16,),
              onTap: () {
                // game item tap
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return GamePage(mySocket: widget.mySocket,);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.lock_clock_rounded),
              title:  textcustom(text:"Time Setting", size: MyString.padding16,),
              onTap: () {
                // game item tap
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return TimePage(mySocket: widget.mySocket,);
                }));
              },
            ),
          ),
          // Card(
          //   child: ListTile(
          //     leading: const Icon(Icons.web),
          //     title:  textcustom(text:"API Configuration", size: MyString.padding16,),
          //     onTap: () {
          //       // game item tap
          //       Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //         return  ConfigPage();
          //       }));
          //     },
          //   ),
          // ),


          const SizedBox(height:MyString.padding16),

          // Padding(
          // padding: const EdgeInsets.only(top: MyString.padding16),
          // child: Center(
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       // Handle logout logic here
          //       debugPrint("Logout clicked!");
          //       showConfirmationDialog(context,"Logout User", () {

          //       });
          //     },
          //     icon: const Icon(Icons.logout,),
          //     label: const Text( "LOGOUT", ),
          //   ),
          // ),),


        ],
      )),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Get the jackpot value and machineId from the state
          return  Stack(
          children: [
          SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: heightCard,
                  decoration: const BoxDecoration(
                    borderRadius:BorderRadius.only(
                      bottomLeft:Radius.circular(MyString.padding36),
                      bottomRight:Radius.circular(MyString.padding36),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        MyColor.pinkBG2,
                        MyColor.pinkBG
                      ], // Gradient colors
                      begin: Alignment.topLeft, // Start gradient from top-left
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  debugPrint("onpress back home page 2");
                                  Navigator.of(context).pop(context);
                                },
                            icon:const Icon(Icons.arrow_back_ios, color: MyColor.white)),
                            IconButton(
                                onPressed: () {
                                  debugPrint("onpress Drawer");
                                  Scaffold.of(context).openDrawer();
                                },
                            icon:const Icon(Icons.menu_rounded, color: MyColor.white)),
                          ],
                        ),
                        // avatarRow(
                        //   height: heightCard,
                        //   width: width,
                        //   userName: "Admin",
                        //   onPressDrawer: (){
                        //     debugPrint("onpress Drawer");
                        //     Scaffold.of(context).openDrawer();
                        //   }
                        // ),
                        const HomeSocketPage2(),
                      ],
                    ),
                  ),
                ),

                //History Page

              ],
            ),
          ),
          Positioned(
            bottom:0,
            child: Container(
                    width:width,
                    height:height-heightCard - (heightRow / 2),
                    color:MyColor.grey_tab,
                    child:const JackpotHistoryPage()
            ),
          ),
          //button row
          Positioned(
            bottom: height - heightCard - (heightRow / 2),
            child: buttonRow(
              width: width,
              height: heightRow,
              context:context,
              // value:'1',
              // machine : '5',
              value:'${state.jackpotValue}',
              machine : '${state.machineId}',
            ),
          ),
        ],
        );
        },
      ));
  }
}







