import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/hive/hive_login_extension.dart';
import 'package:tnm_app_slot_aft/model/loginModel.dart';
import 'package:tnm_app_slot_aft/page/select/selectpage.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/service/service_hive_login.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';
import 'package:tnm_app_slot_aft/widget/textfield_title_custom.dart';

class LoginPage extends StatefulWidget {

   const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerUserName = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

   bool checkboxValue = false;
   final ServiceAPIsSlot serviceAPIs = ServiceAPIsSlot();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allows the body to resize when the keyboard is displayed
      body:SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
          width:width,
          height:height,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width:width,
                height:height/3,
                decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/login2.png'),fit: BoxFit.cover,filterQuality: FilterQuality.low)
              ),
              ),
              const SizedBox(height:MyString.padding16),
              textcustomCenter(text:"VEGAS TOURNAMENT",size: MyString.padding24),
              const SizedBox(height:MyString.padding16),
              mytextFieldTitle(
                margin:MyString.padding16,
                width: width,
                controller:controllerUserName,
                hint: "Username",
                prefixIcon: const Icon(Icons.person),
                enable: true,
                textinputType: TextInputType.text,
                label:"Username"
              ),
              const SizedBox(height:MyString.padding16),
              mytextFieldTitle(
                margin:MyString.padding16,
                width: width,
                obscureText:true,
                controller:controllerPassword,
                hint: "Password",
                prefixIcon: const Icon(Icons.lock),
                enable: true,
                textinputType: TextInputType.text,
                label:"Password"
              ),

              CheckboxListTile(
                title: const Text('Remember Me'),
                value: checkboxValue, onChanged: (value){
                  debugPrint("value checkbox: $value");
                  setState(() {
                    checkboxValue = value ?? false; // Corrected toggle logic
                  });
              }),

              //LOGIN BUTTON
              const SizedBox(height:MyString.padding32),
              customButton(margin: MyString.padding16, width: width, text: "LOGIN", onTap: ()  {
              debugPrint('Press Login ${controllerUserName.text} ${controllerPassword.text} $checkboxValue');
                //  Navigator.of(context).pushNamed("/home");
                serviceAPIs.login(username: controllerUserName.text, password: controllerPassword.text).then((LoginModel v) async {
                  if(v.status==true)  {
                    if (checkboxValue == true) {
                      await HiveServiceLogin.saveLoginData(v.toHiveModel());
                      debugPrint('Data saved to Hive');
                    }
                    debugPrint('serviceAPIs.login status == true: ${v.data.username}');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> SelectPage(loginModel:v,)));
                  }else{
                    debugPrint('serviceAPIs.login == false: $v');
                    showSnackBar(context:context,message:"fail to login, please retry");
                  }
                });
                debugPrint('name: ${controllerUserName.text} , passs: "${controllerPassword.text} checkbox: {$checkboxValue}');
              })

            ],
          )
          ),
        ),
      ),
    );
  }
}
