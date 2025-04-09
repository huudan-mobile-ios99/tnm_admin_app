
import 'package:tnm_app_slot_aft/service/service_hive_api.dart';

class MyAPIStringRL {




  static String get BASE_RL {
    var config = HiveAPIConfigService.getAPIConfig();
    return config?.rlEndpoint ?? 'http://192.168.101.58:8096/api/';
  }

   static String get BASEURL_WEBSOCKET_RL {
    var config = HiveAPIConfigService.getAPIConfig();
    return config?.rlEndpointSocket ?? 'http://192.168.101.58:8096/';
  }




  static final String create_round_rl = '${BASE_RL}create_round';
  static final String create_round_realtime_rl = '${BASE_RL}save_list_station';








  static final String list_station_rl = '${BASE_RL}list_station';
  static final String list_ranking_data_rl = '${BASE_RL}list_ranking_data';
  static final String update_ranking_by_id_rl = '${BASE_RL}update_ranking_id';
  static final String update_member_station_rl = '${BASE_RL}update_member';


  static final String  update_member= '${BASE_RL}update_ranking_id';


  static final String add_ranking_realtime_rl = '${BASE_RL}add_ranking_realtime';
  static final String delete_ranking_all_and_add = '${BASE_RL}delete_ranking_all_create_default';


  static final String list_round_rl = '${BASE_RL}list_round';
  static final String list_round_realtime = '${BASE_RL}list_ranking_realtime_group';


}
