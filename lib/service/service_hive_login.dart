import 'package:hive_flutter/hive_flutter.dart';
import '../model/hive/hive_loginModel.dart';

class HiveServiceLogin {
  static const String _boxName = "loginBox";

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveLoginModelAdapter());
    Hive.registerAdapter(HiveLoginModelDataAdapter());
    await Hive.openBox<HiveLoginModel>(_boxName);
  }

  static Future<void> saveLoginData(HiveLoginModel loginModel) async {
    var box = Hive.box<HiveLoginModel>(_boxName);
    await box.put("user", loginModel);
  }

  static HiveLoginModel? getLoginData() {
    var box = Hive.box<HiveLoginModel>(_boxName);
    return box.get("user");
  }

  static bool isUserLoggedIn() {
    return getLoginData() != null;
  }

  static Future<void> clearLoginData() async {
    var box = Hive.box<HiveLoginModel>(_boxName);
    await box.delete("user");
  }
}

