import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

class SocketManagerSlot {
  static final SocketManagerSlot _instance = SocketManagerSlot._();
  factory SocketManagerSlot() {
    return _instance;
  }
  IO.Socket? _socket;
  late StreamController<List<Map<String, dynamic>>>_streamControllerJackpotDrop; //from mongodb data
  IO.Socket? get socket => _socket;


  Stream<List<Map<String, dynamic>>> get dataStreamJackpotDrop => _streamControllerJackpotDrop.stream;

  SocketManagerSlot._() {
    //jackpot drop
    _streamControllerJackpotDrop = StreamController<List<Map<String, dynamic>>>.broadcast();
  }

  void initSocket() {
    debugPrint('initSocket');
    _socket = IO.io(MyString.BASEURL_WEBSOCKET_SLOT, <String, dynamic>{
      // 'autoConnect': false,
      // 'transports': ['websocket'],
      'autoConnect': true, // Auto reconnect
      'reconnection': true, // Enable reconnections
      'reconnectionAttempts': 10, // Number of reconnection attempts
      'reconnectionDelay': 5000, // Delay between reconnections
      'transports': ['websocket'],
    });


    //JACKPOT FROM MONGODB
    _socket?.on('eventJPDrop', (data) {
      // debugPrint('eventJPDrop log: $data');
      processJackpotDrop(data);
    });

    _socket?.connect();
  }

  void connectSocket() {
    debugPrint('connectSocket');
    _socket?.connect();
  }

  void disposeSocket() {
    debugPrint('disposeSocket');
    _socket?.disconnect();
    _socket = null;
  }


  void processJackpotDrop(dynamic data) {
    for (var jsonData in data) {
      // debugPrint('processJackpotDrop JSON: $jsonData');
      try {
        // Create a Map to represent the display data
        Map<String, dynamic> data = {
          "_id": jsonData['_id'],
          "name": jsonData['name'],
          "value": jsonData['value'],
          "machineId":jsonData['machineId'],
          "count": jsonData['count'],
          "status": jsonData['status'],
          "createdAt": jsonData['createdAt'],
          "__v": jsonData['__v'],
        };
        _streamControllerJackpotDrop.add([data]);
      } catch (e) {
        debugPrint('Error parsing data jp drop: $e');
      }
    }
  }


  void emitJackpotDrop() {
    debugPrint('emitJackpotDrop');
    socket!.emit('emitJPDrop');
  }

    //update vegas prize
  void updateJackpotSettings(Map<String, dynamic> newSettings) {
    socket!.emit('updateJackpotSetting', newSettings);
  }

  //emit jackpot data
  void emitJackpotNumberInit() {
    debugPrint('emitJackpotNumberInit');
    socket!.emit('emitJackpotNumberInitial');
  }

  //emit data setting
  void emitSetting() {
    socket!.emit('emitSetting');
  }

  Future<void> emitEventFromClient2Force() async {
    socket!.emit('eventFromClient2_force');
  }



  //emit data time
  void emitTime() {
    socket!.emit('emitTime');
  }

}
