import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/page/config/configpage.dart';
import 'package:tnm_app_slot_aft/model/loginModel.dart';
import 'package:tnm_app_slot_aft/page/home2/home2.dart';
import 'package:tnm_app_slot_aft/page/home2/home_avatar.dart';
import 'package:tnm_app_slot_aft/page/jackpot/dialog.confirm.dart';
import 'package:tnm_app_slot_aft/page/login/login_page.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/rankingrl_tab.dart';
import 'package:tnm_app_slot_aft/page/user_info/user_infopage.dart';
import 'package:tnm_app_slot_aft/service/service_hive_login.dart';
import 'package:tnm_app_slot_aft/service/service_socket_rl.dart';
import 'package:tnm_app_slot_aft/service/service_socket_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


// ignore: must_be_immutable
class SelectPage extends StatefulWidget {

  SelectPage({super.key,required this.loginModel});
  LoginModel loginModel;


  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  late final SocketManagerSlot mySocketSlot = SocketManagerSlot();
  late final SocketManagerRL mySocketRL = SocketManagerRL();


  @override
  void initState() {
    debugPrint("initsocket selectpage");
    mySocketSlot.initSocket();
    mySocketRL.initSocket();
    super.initState();
  }


  @override
  void dispose() {
    debugPrint("dispose socket selectpage");
    super.dispose();
    mySocketSlot.disposeSocket();
    mySocketRL.disposeSocket();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double heightCard = height * .425;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
        backgroundColor: MyColor.appBar,
        title: Builder(
          builder: (context) {
            return avatarRow(
                              height: heightCard,
                              width: width,
                              imageUrl: widget.loginModel.data.imageUrl,
                              userName: widget.loginModel.data.username,
                              onPressSetting: (){
                                debugPrint("onpress avatar icon setting");
                                Scaffold.of(context).openDrawer();
                              }
            );
          }
        ),
      ),
      drawer: Drawer(
      backgroundColor: MyColor.white,
      elevation: MyString.padding02,
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
           DrawerHeader(
            padding: const EdgeInsets.all(MyString.padding08),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [MyColor.appBar,MyColor.white])
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
                Center(child: textcustom(text:"TNM Main Menu",size: MyString.padding22,isBold: true)),
              ],
            )
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title:  textcustom(text:"User Info", size: MyString.padding16,),
              onTap: () {
                // game item tap
                debugPrint("onTap user info");
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return   UserInfoPage(loginModel:widget.loginModel);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.web),
              title:  textcustom(text:"API Configuration", size: MyString.padding16,),
              onTap: () {
                // game item tap
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return  const ConfigPage();
                }));
              },
            ),
          ),
          const SizedBox(height:MyString.padding16),

          Padding(
          padding: const EdgeInsets.only(top: MyString.padding16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle logout logic here
                debugPrint("Logout clicked!");
                showConfirmationDialog(context,"Logout User", () async{
                    await HiveServiceLogin.clearLoginData().then((v){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),  // Replace with your actual LoginPage
                          (route) => false,  // This ensures all previous routes are removed
                        );
                    });
                });
              },
              icon: const Icon(Icons.logout,),
              label: const Text( "LOGOUT", ),
            ),
          ),),


        ],
      )),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: MyString.padding24, vertical: MyString.padding24),
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: MyColor.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                textcustom(text:"SELECT TYPE",isBold: true,size:MyString.padding24),
                const SizedBox(
                  height: MyString.padding26,
                ),
                GestureDetector(
                  onTap: (){
                    debugPrint("onPress rl");
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    //     return RankingRLPage(mySocket:mySocketRL);
                    // }));
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return RankingRlTab(mySocket:mySocketRL);
                    }));

                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: width,
                        height: 175.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MyString.padding04),
                          image: const DecorationImage(image: AssetImage("asset/bg_rl.png"),fit: BoxFit.contain)
                        ),
                      ),
                      textcustom(text:"ROULETTE TNM",size:MyString.padding16,isBold:true),

                    ],
                  ),
                ),
                const SizedBox(
                  height: MyString.padding32,
                ),
                GestureDetector(
                  onTap: (){
                    debugPrint("press slot");
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          return HomePage2(mySocket:mySocketSlot);
                    }));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: width,
                        height: 175.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MyString.padding04),
                          image: const DecorationImage(image: AssetImage("asset/bg_slot.png"),fit: BoxFit.contain)
                        ),
                      ),
                      textcustom(text:"SLOT TNM",size:MyString.padding16,isBold:true),
                    ],
                  ),
                ),

              ],
            )),
      ),

    );
  }
}
