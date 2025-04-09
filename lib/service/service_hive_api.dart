import 'package:hive_flutter/hive_flutter.dart';
import '../model/hive/hive_api_config_model.dart';

class HiveAPIConfigService {
  static const String _boxName = "apiConfigBox";

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveAPIConfigModelAdapter());
    await Hive.openBox<HiveAPIConfigModel>(_boxName);
  }

  static Future<void> saveAPIConfig({required String rlEndpoint,required String slotEndpoint,required String rlEndpointSocket,required String slotEndpointSocket}) async {
    var box = Hive.box<HiveAPIConfigModel>(_boxName);
    final config = HiveAPIConfigModel(rlEndpoint: rlEndpoint, slotEndpoint: slotEndpoint,rlEndpointSocket: rlEndpointSocket,slotEndpointSocket: slotEndpointSocket);
    await box.put("config", config);
  }

  static HiveAPIConfigModel? getAPIConfig() {
    var box = Hive.box<HiveAPIConfigModel>(_boxName);
    return box.get("config");
  }

  static Future<void> clearAPIConfig() async {
    var box = Hive.box<HiveAPIConfigModel>(_boxName);
    await box.delete("config");
  }
}
