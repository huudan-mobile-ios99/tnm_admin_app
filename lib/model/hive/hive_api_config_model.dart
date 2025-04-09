import 'package:hive/hive.dart';
import 'package:tnm_app_slot_aft/util/string_custom_rl.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

part 'hive_api_config_model.g.dart';

@HiveType(typeId: 2)
class HiveAPIConfigModel extends HiveObject {
  @HiveField(0)
  String rlEndpoint;

  @HiveField(1)
  String slotEndpoint;

  @HiveField(2)
  String rlEndpointSocket;

  @HiveField(3)
  String slotEndpointSocket;

  HiveAPIConfigModel({
    required this.rlEndpoint,
    required this.slotEndpoint,
    required this.rlEndpointSocket,
    required this.slotEndpointSocket,
  });

  /// Provide default values to prevent null errors
  factory HiveAPIConfigModel.fromMap(Map<String, dynamic> map) {
    return HiveAPIConfigModel(
      rlEndpoint: map['rlEndpoint'] ?? MyAPIStringRL.BASE_RL,
      slotEndpoint: map['slotEndpoint'] ?? MyString.BASE_SLOT,
      rlEndpointSocket: map['rlEndpointSocket'] ?? MyAPIStringRL.BASEURL_WEBSOCKET_RL,
      slotEndpointSocket: map['slotEndpointSocket'] ?? MyString.BASEURL_WEBSOCKET_SLOT,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rlEndpoint': rlEndpoint,
      'slotEndpoint': slotEndpoint,
      'rlEndpointSocket': rlEndpointSocket,
      'slotEndpointSocket': slotEndpointSocket,
    };
  }
}
