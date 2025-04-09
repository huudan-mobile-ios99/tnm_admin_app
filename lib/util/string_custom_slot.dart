import 'package:flutter/foundation.dart';
import 'package:tnm_app_slot_aft/service/service_hive_api.dart';

class MyString {
  static const String APP_NAME = "TNM SLOT AFT";


  static String get BASE_SLOT {
    var config = HiveAPIConfigService.getAPIConfig();
    return config?.slotEndpoint ?? 'http://192.168.101.58:8086/api/';
  }

   static String get BASEURL_WEBSOCKET_SLOT {
    var config = HiveAPIConfigService.getAPIConfig();
    return config?.slotEndpointSocket ?? 'http://192.168.101.58:8086/';
  }


  static String list_data_station = '${BASE_SLOT}find_data';
  static  String list_ranking = '${BASE_SLOT}list_ranking';
  static  String list_ranking_data = '${BASE_SLOT}list_ranking_data';
  static  String export_round = '${BASE_SLOT}export_round';
  static  String export_round_realtime = '${BASE_SLOT}export_round_realtime';
  static String downloadround(name) {
    String url = '${BASE_SLOT}download_excel/$name';
    debugPrint(url);
    return url;
  }

  static  String list_round = '${BASE_SLOT}list_round';
  static  String list_round_realtime =  '${BASE_SLOT}list_ranking_realtime_group';
  static  String create_round = '${BASE_SLOT}create_round';
  static  String create_round_realtime = '${BASE_SLOT}save_list_station';



  // static  String create_round_rl = '${BASE_RL}create_round';
  // static  String create_round_realtime_rl = '${BASE_RL}save_list_station';


  static  String create_round_input = '${BASE_SLOT}create_round_input';
  static  String create_ranking = '${BASE_SLOT}add_ranking';
  static  String update_ranking = '${BASE_SLOT}update_ranking';
  static  String update_ranking_by_id = '${BASE_SLOT}update_ranking_id';
  static  String delete_ranking = '${BASE_SLOT}delete_ranking';
  static String delete_ranking_byid(id) {
    final url = '${BASE_SLOT}delete_ranking_id/$id';
    debugPrint('delete_ranking_by id url : $url');
    return url;
  }




  static  String login = '${BASE_SLOT}login';




  static  String delete_ranking_all_and_add = '${BASE_SLOT}delete_ranking_all_create_default';
  static  String list_station_slot = '${BASE_SLOT}list_station';
  // static  String list_station_rl = '${BASE_RL}list_station';
  static  String update_member_station_slot = '${BASE_SLOT}update_member';
  // static  String update_member_station_rl = '${BASE_RL}update_member';
  static  String create_station = '${BASE_SLOT}create_station';
  static  String delete_station = '${BASE_SLOT}delete_station';
  static  String update_station_status = '${BASE_SLOT}update_station';
  static  String update_station_aft = '${BASE_SLOT}update_aft';
  static  String update_status_all = '${BASE_SLOT}update_status_all';
  static  String add_ranking_realtime = '${BASE_SLOT}add_ranking_realtime';
  // static  String add_ranking_realtime_rl = '${BASE_RL}add_ranking_realtime';
  static  String settings = '${BASE_SLOT}findsetting';
  static  String setting_update = '${BASE_SLOT}update_setting';
  //JACKPOT HISTORY
  static  String jackpot_history = '${BASE_SLOT}jackpot_drop/jackpot_drop_paging?page=1&limit=30';

  //DEFAULT PADDING IN SETTING
  static  double TOP_PADDING_TOPRAKINGREALTIME = 18.0;

  //DISPLAY
  static String update_display(id) {
    return '${BASE_SLOT}update_display/$id';
  }

  //DISPLAY REALTOP
  static String update_display_realtop(id) {
    return '${BASE_SLOT}update_display_realtop/$id';
  }

  //DISPLAY
  static String list_display = '${BASE_SLOT}list_display';

  //TIME
  static  String get_latest_active_time = '${BASE_SLOT}time/find_time_first';
  static  String update_time_by_id = '${BASE_SLOT}time/update_time';
  static  String update_time_latest = '${BASE_SLOT}time/update_time_latest';
  //STREAM
  static  String get_stream_all = '${BASE_SLOT}stream/all_stream';
  //JACKPOT
  static  String get_jackpot_all = '${BASE_SLOT}jackpot/all_jackpot';
  static String delete_jackpot_by_id (id){
    return '${BASE_SLOT}jackpot_drop/delete_jackpot_drop/$id';
  }
  //DEVICE
  static final CREATE_NEW_DEVICE = "${BASE_SLOT}device/create_device";
  static final LIST_DEVICE_ALL = "${BASE_SLOT}device/list_device";
  static String delete_device_by_id (id){
    return '${BASE_SLOT}device/delete_device/$id';
  }
  static String update_device_by_id (id){
    return '${BASE_SLOT}device/update_device/$id';
  }

  static  int TIME_INIT = 0;
  static  int TIME_START = 1;
  static  int TIME_PAUSE = 2;
  static const int TIME_RESUME = 3;
  static const int TIME_STOP = 4;
  static const int TIME_SET = 5;
  static const int TIME_DEFAULT_MINUTES = 5;

  static const int TIME_OUT = 15;


  static const double padding02 = 02.0;
  static const double padding04 = 04.0;
  static const double padding06 = 06.0;
  static const double padding08 = 08.0;
  static const double padding16 = 16.0;
  static const double padding12 = 12.0;
  static const double padding14 = 14.0;
  static const double padding20 = 20.0;
  static const double padding22 = 22.0;
  static const double padding24 = 24.0;
  static const double padding26 = 26.0;
  static const double padding28 = 28.0;
  static const double padding18 = 18.0;
  static const double padding32 = 32.0;
  static const double padding36 = 36.0;
  static const double padding38 = 38.0;
  static const double padding42 = 42.0;
  static const double padding46 = 46.0;
  static const double padding48 = 48.0;
  static const double padding56 = 56.0;
  static const double padding64 = 64.0;
  static const double padding72 = 72.0;
  static const double padding84 = 84.0;
  static const double padding96 = 96.0;
  static const double padding116 = 116.0;
  static const String fontFamily = 'Poppins';


  //JP Min Max Value
  static const double JPPriceMin = 50;
  static const double JPPriceMax = 100;
  static const double JPPricePercent = 0.5;
  static const double JPPriceThresHold = 85;
  static const int JPThrotDuration = 7; //7 seconds
  static const String DEFAULT_COLUMN = '9'; //7 seconds


  //JP MAX
  static const double JPPercentMax = 5;

}
