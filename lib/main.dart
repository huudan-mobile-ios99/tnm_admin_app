import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tnm_app_slot_aft/model/hive/hive_loginModel.dart';
import 'package:tnm_app_slot_aft/model/hive/hive_login_extension.dart';
import 'package:tnm_app_slot_aft/page/home/home.dart';
import 'package:tnm_app_slot_aft/page/list/station_page.dart';
import 'package:tnm_app_slot_aft/page/login/login_page.dart';
import 'package:tnm_app_slot_aft/page/select/selectpage.dart';
import 'package:tnm_app_slot_aft/service/service_hive_api.dart';
import 'package:tnm_app_slot_aft/service/service_hive_login.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

void main() async{
  await HiveServiceLogin.init(); // Initialize Hive

  await HiveAPIConfigService.init();
  runApp(const MyApp(),
    );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyString.APP_NAME,
      debugShowCheckedModeBanner:false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home:  BlocProvider(
      //   create: (context) => TabBloc(),
      //   child: const TabPage(),
      // ),
      // home:LoginPage(),
      // home: LoginPage(),
      home: getInitialPage(), // Dynamic home page

      // home: const SelectPage(),
      // home:const HomePage2(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/home2': (context) => const HomePage(),
        '/list': (context) => const ListPage(),
      },
    );
  }
  /// Determines which page to show at startup
  Widget getInitialPage() {
    HiveLoginModel? user = HiveServiceLogin.getLoginData();
    return user != null ?  SelectPage(loginModel: user.toLoginModel()) : const LoginPage();
  }
}



