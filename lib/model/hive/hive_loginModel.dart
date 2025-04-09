import 'package:hive/hive.dart';
part 'hive_loginModel.g.dart';

@HiveType(typeId: 0) // Unique ID for Hive
class HiveLoginModel extends HiveObject {
  @HiveField(0)
  final bool status;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final HiveLoginModelData data;

  HiveLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
}

@HiveType(typeId: 1) // Unique ID for nested data
class HiveLoginModelData extends HiveObject {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final int v;

  @HiveField(6)
  final String role;

  HiveLoginModelData({
    required this.imageUrl,
    required this.id,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.v,
    required this.role,
  });
}
