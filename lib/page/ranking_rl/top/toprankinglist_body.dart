

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/rankingrlpage.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/top/bloc/list_rl_bloc.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/top/topranking_title.dart';
import 'package:tnm_app_slot_aft/service/service_api_rl.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/bottom_loader.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';








class TopRankingListBody extends StatefulWidget {
  const TopRankingListBody({super.key});

  @override
  State<TopRankingListBody> createState() => _TopRankingListBodyState();
}

class _TopRankingListBodyState extends State<TopRankingListBody> {
  final _scrollController = ScrollController();
  final ServiceAPIsRL service_api = ServiceAPIsRL();
  final TextEditingController controllerPointCurrent =  TextEditingController();
  final TextEditingController controllerPointNew = TextEditingController();
  final TextEditingController controllerMemberCurrent = TextEditingController();
  final TextEditingController controllerMemberNew = TextEditingController();
  final DateFormatter format_date = DateFormatter();


  @override
  void initState() {
    super.initState();
    //debugPrint("add listener");
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ListRLBloc, ListRLState>(
      builder: (context, state) {
        switch (state.status) {
          case ListRLStatus.failure:
            return Center(
              child: TextButton(
              onPressed: () {
                context.read<ListRLBloc>().add(ListRLFetched());
                // ignore: invalid_use_of_visible_for_testing_member
                context.read<ListRLBloc>().emit(const ListRLState());
              },
              child: const Text('no ranking founds,press to retry'),
            ));
          case ListRLStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no rankings'));
            }

            return Column(
              children: [
                topRankingTitle(context:context,width:width,),
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _onRefresh();
                    },
                    child:
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.posts.length
                            ? BottomLoaderCustom(
                                function: () => _onRefresh(),
                              )
                            : Container(
                                  decoration:const BoxDecoration(
                                    border:Border(
                                      bottom: BorderSide( // <--- left side
                                        color: MyColor.grey_tab,
                                      ),
                                    ),
                                  ),
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
                                              text: state.posts[index].customerNumber),
                                        ),

                                        itemListRT(
                                          width: width,
                                          child: textcustom(
                                            size:MyString.padding12,
                                              text: '${state.posts[index].customerName}'),
                                        ),

                                        itemListRT(
                                          width: width,
                                          child: textcustom(
                                            size:MyString.padding12,
                                              text:'${state.posts[index].point}\$'),
                                        ),

                                        itemListRT(
                                            width: width,
                                            child: textcustom(
                                              size: MyString.padding12,
                                              text:format_date.formatDateSlashShort(DateTime.parse(state.posts[index].createdAt!))
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
                                                      debugPrint( 'update  member  in RL TOP  Ranking${state.posts[index].customerName}');
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
                                                                        text: '${state.posts[index].customerNumber}',
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
                                                                              debugPrint("click yes ${state.posts[index].id}  ${controllerMemberNew.text}");
                                                                              if(controllerMemberNew.text==controllerMemberCurrent.text || controllerMemberNew.text.isEmpty){
                                                                                showSnackBar(context:context, message:"Invalid fields ");
                                                                              }
                                                                              else{
                                                                                service_api.updateRankingRLById(
                                                                                id:state.posts[index].id!,
                                                                                customer_number:controllerMemberNew.text,
                                                                                point: state.posts[index].point!,
                                                                                ).then((v){
                                                                                  debugPrint(v);
                                                                                }).whenComplete((){
                                                                                  Navigator.of(context).pop();
                                                                                  _onRefresh();
                                                                                });
                                                                              }
                                                                            }
                                                                          ),

                                                                          customButtonIcon(
                                                                            width:width / 3,
                                                                            textSize: MyString.padding16,
                                                                            icon:const Icon(Icons.close_rounded,color:MyColor.red),
                                                                            text:"CANCEL",
                                                                            onTap: (){
                                                                              debugPrint("click cancel ranRking page  detail");
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
                                );
                      },
                      itemCount: state.hasReachedMax
                          ? state.posts.length
                          : state.posts.length + 1,
                      controller: _scrollController,
                    ),
                  ),
                ),
              ],
            );
          case ListRLStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('reach bottom ');
    if (_isBottom) context.read<ListRLBloc>().add(ListRLFetched());
  }

  void _onRefresh() {
    context.read<ListRLBloc>().add(ListRLFetched());
    // ignore: invalid_use_of_visible_for_testing_member
    context.read<ListRLBloc>().emit(const ListRLState());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }
}
