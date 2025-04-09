import 'dart:async';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:tnm_app_slot_aft/model/rankingRLModel.dart';
import 'package:tnm_app_slot_aft/model/roundModel.dart';
import 'package:tnm_app_slot_aft/model/roundModelRealtime.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';

import 'package:tnm_app_slot_aft/util/string_custom_rl.dart';

class ServiceAPIsRL {
  Dio dio = Dio();
  final Duration receiveAndSendTimeout = const Duration(seconds:15);
Future<ListStationModel?> listStationDataRL() async {
    try {
      final response = await dio.get(
        MyAPIStringRL.list_station_rl,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      // debugPrint('${response.data}');
      return ListStationModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }


  //ADD ALL REALTIME RANKING
  Future<dynamic> addRealTimeRankingRL() async {
    debugPrint('addRealTimeRanking');
    try {
      final response = await dio.post(
        MyAPIStringRL.add_ranking_realtime_rl,
        data: null,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      // print(response.data);
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }


  Future<dynamic> deleteRankingAllAndAddDefaultRL() async {
    try {
      final response = await dio.delete(
        MyAPIStringRL.delete_ranking_all_and_add,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      // debugPrint(response.data);
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }


  //create new round
  Future<dynamic> createRoundRL(
      // {required List<Ranking>? rankings}
      ) async {
    // Map<String, dynamic> body = {
    //   "rankings": rankings,
    // };
    try {
      final response = await dio.post(
        MyAPIStringRL.create_round_rl,
        data: null,
        // data: body,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      // print(response.data);
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }

  //create new round realtime
  Future<dynamic> createRoundRealTimeRL() async {
    try {
      final response = await dio.get(
        MyAPIStringRL.create_round_realtime_rl,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }



  //update member station
  Future<dynamic> updateMemberStationRL({ip, member}) async {
    final Map<String, dynamic> body = {"ip": ip, "member": member};
    try {
      final response = await dio.post(
        MyAPIStringRL.update_member_station_rl,
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }





 Future<List<RankingRL>> fetchRankingRL([int startIndex = 0, postLimit]) async {
    const postLimit = 20;
    try {
      debugPrint('_fetchRaking');
      final dio = Dio();
      final response = await dio.get(
        MyAPIStringRL.list_ranking_data_rl, // Use http instead of https if it's not secured
        queryParameters: {'start': '$startIndex', 'limit': '$postLimit'},
      );
      if (response.statusCode == 200) {
        debugPrint('200 status');
        final body = response.data as List;
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return RankingRL(
            id: map['_id'] as String?,
            customerName: map['customer_name'] as String?,
            customerNumber: map['customer_number'] as String?,
            point:  (map['point'] as num?)?.toDouble(),
            createdAt: map['createdAt'] as String?,
            v: map['_v'] as int?,
          );
        }).toList();
      } else {
        debugPrint('something wrong');
        return [];
      }
    } catch (e) {
      debugPrint('something went wrong $e');
      return [];
    }

  }

  //List rounds
  Future<RoundModel?> listRoundTopRankingRL() async {
    try {
      final response = await dio.get(
        MyAPIStringRL.list_round_rl,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      return RoundModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e.message);
    }
    return null;
  }


   Future<dynamic> updateRankingRLById({required  customer_number,required   point,required  id}) async {
    Map<String, dynamic> body = {
      "customer_number": customer_number,
      "customer_name": customer_number,
      "point": point,
      "_id": id
    };
    try {
      final response = await dio.put(
        MyAPIStringRL.update_ranking_by_id_rl,
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
          receiveTimeout: receiveAndSendTimeout,
          sendTimeout: receiveAndSendTimeout,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint(response.data.toString());
      return (response.data);
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }



  //List rounds realtime ranking
  Future<ListRoundRealTimeModel?> listRoundRealTimeRL() async {
    final response = await dio.get(
      MyAPIStringRL.list_round_realtime,
      options: Options(
        contentType: Headers.jsonContentType,
        receiveTimeout: receiveAndSendTimeout,
        sendTimeout: receiveAndSendTimeout,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    // print(response.data);
    return ListRoundRealTimeModel.fromJson(response.data);
  }
}

