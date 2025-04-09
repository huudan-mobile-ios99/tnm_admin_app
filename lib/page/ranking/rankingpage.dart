import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import 'package:tnm_app_slot_aft/page/hover/hover_cubit.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';


// ignore: must_be_immutable
class RankingPage extends StatefulWidget {

  SocketManagerSlot? mySocket;
  RankingPage({required this.mySocket, super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final TextEditingController controllerMember = TextEditingController();
  final TextEditingController controllerMC = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final serviceAPIs = ServiceAPIsSlot();
  late Future<ListStationModel?> _futureData;


  @override
  void initState() {
    debugPrint('initState SetupPage slot');
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
    debugPrint("dispose rankingpage slot");
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
          title: textcustomColor(text:'Ranking Real Time ',size:MyString.padding16,color:MyColor.white,isBold: true),
          actions: const [
            // TextButton.icon(
            //     icon:const Icon(Icons.bar_chart,color:MyColor.white),
            //     onPressed: () {
            //         debugPrint('reset member from 1->8');
            //     },
            //     label: const SizedBox(),),


          ],
        ),
        body: FutureBuilder(
          future: _futureData,
          builder: (BuildContext context,  AsyncSnapshot<ListStationModel?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text('Failed to load data.'),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                            debugPrint('retry load connection db');
                            //RETRY HERE
                            refreshData();
                          },
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final ListStationModel? model = snapshot.data;
            return Container(
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              height: height,
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: itemListRT(
                              width: width,
                              child:textcustom(text: '#', size: MyString.padding14, isBold: false),
                            ),
                          ),
                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Member', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(
                              text: 'IP', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Credit', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Connect', size: MyString.padding14, isBold: false)),

                          Expanded(
                              child: itemListRT(
                                  width: width,
                                  child: textcustom(
                                      text: 'Action',
                                      size: MyString.padding14,
                                      isBold: false))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async{
                        refreshData();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocProvider(
                                create: (_) => HoverCubit(),
                                child: BlocBuilder<HoverCubit,bool>(
                                  builder: (context, state) =>  MouseRegion(
                                    onEnter: (_) => context.read<HoverCubit>().onHoverEnter(),
                                    onExit: (_) => context.read<HoverCubit>().onHoverExit(),
                                    child: Container(
                                      color: state ? MyColor.bedgeLight :Colors.transparent,
                                      child: ListTile(
                                        contentPadding:const EdgeInsets.all(0.0),
                                        title: Row(
                                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            itemListRT(
                                              width: width,
                                              child: textcustom(
                                                size:MyString.padding12,text: '${index + 1}'),
                                            ),
                                            itemListRT(
                                              width: width,
                                              child: textcustom(
                                                size:MyString.padding12,
                                                  text: model.list[index].member),
                                            ),

                                            itemListRT(
                                              width: width,
                                              child: textcustom(
                                                size:MyString.padding12,
                                                  text: '${model.list[index].ip}'),
                                            ),

                                            itemListRT(
                                              width: width,
                                              child: textcustom(
                                                size:MyString.padding12,
                                                  text:'${model.list[index].credit / 100}\$'),
                                            ),

                                            itemListRT(
                                                width: width,
                                                child: textcustomColor(
                                                  size: MyString.padding12,
                                                  text: model.list[index].connect == 1
                                                      ? 'connected'
                                                      : '...',
                                                  color: model.list[index].connect == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                                )),

                                            Expanded(
                                              child: itemListRT(
                                                width: width,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        tooltip: 'update member',
                                                        onPressed: () {
                                                          debugPrint( 'update ${model.list[index].member}');
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        icon: const Icon(Icons.edit),
                                                                        title: textcustom(text:'Confirm Update RT'),
                                                                        content: Column(
                                                                          mainAxisSize:MainAxisSize.min,
                                                                          children: [
                                                                            textcustom(text:  "Are you sure to update this member?"),
                                                                            const Divider(color: MyColor.grey_tab),

                                                                            mytextFieldTitleWithValue(
                                                                            margin:MyString.padding02,
                                                                            width: width,
                                                                            controller:controllerMemberCurrent,
                                                                            text: model.list[index].member,
                                                                            hint: "Current Member",
                                                                            prefixIcon: const Icon(Icons.person),
                                                                            enable: true,
                                                                            textinputType: TextInputType.text,
                                                                            label:"Current Member"
                                                                            ),
                                                                            const SizedBox(height:MyString.padding08),
                                                                            mytextFieldTitle(
                                                                            margin:MyString.padding02,
                                                                            width: width,
                                                                            controller:controllerMemberNew,
                                                                            hint: "New Member",
                                                                            prefixIcon: const Icon(Icons.person_add),
                                                                            enable: true,
                                                                            textinputType: TextInputType.number,
                                                                            label:"New Member"
                                                                            ),

                                                                          ],
                                                                        ),
                                                                        actions: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              customButtonIcon(
                                                                                width:width / 3,
                                                                                textSize: MyString.padding16,
                                                                                icon:const Icon(Icons.done_all_rounded,color:MyColor.green),
                                                                                text:"SUBMIT",
                                                                                onTap: (){
                                                                                  debugPrint("click yes");
                                                                                  try {
                                                                                      debugPrint('ip & member: ${model.list[index].ip} ${model.list[index].member}');
                                                                                      if (controllerMemberNew.text == '' ||
                                                                                          controllerMemberNew.text == model.list[index].member) {
                                                                                          showSnackBar(context: context, message: "Invalid input. Please use a new member number ");
                                                                                      } else {
                                                                                        serviceAPIs.updateMemberStationSLOT(
                                                                                          ip: model.list[index].ip,
                                                                                          member: controllerMemberNew.text,
                                                                                        ).then((value) {
                                                                                          showSnackBar(context: context, message: value['message']);
                                                                                          controllerMemberNew.clear();
                                                                                        }).whenComplete(() {
                                                                                          Navigator.of(context).pop();
                                                                                          controllerMemberNew.clear();
                                                                                          refreshData();
                                                                                        });
                                                                                      }
                                                                                    } catch (e) {
                                                                                      debugPrint('$e');
                                                                                      Navigator.of(context).pop();
                                                                                    }
                                                                                },
                                                                              ),

                                                                              customButtonIcon(
                                                                                width:width / 3,
                                                                                textSize: MyString.padding16,
                                                                                icon:const Icon(Icons.close_rounded,color:MyColor.red),
                                                                                text:"CANCEL",
                                                                                onTap: (){
                                                                                  debugPrint("click cancel ranking page  detail");
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ));
                                                        },
                                                        icon: const Icon(Icons.edit)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                               Container(color: MyColor.grey_tab,height: 1.0,),
                            ],
                          );
                        },
                        itemCount: model!.list.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}



Widget itemListRT({width, child}) {
  return Container(
    // padding: EdgeInsets.all(0.0),
    alignment: Alignment.centerLeft,
    width: width / 6,
    child: Center(child: child),
  );
}
