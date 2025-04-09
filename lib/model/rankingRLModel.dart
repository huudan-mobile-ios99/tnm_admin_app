

class RankingRLModel {
  final bool? status;
  final String? message;
  final int? totalResult;
  final List<RankingRL>? data;

  RankingRLModel({
    required this.status,
    required this.message,
    required this.totalResult,
    required this.data,
  });

  factory RankingRLModel.fromJson(Map<String, dynamic> json) {
    return RankingRLModel(
      status: json["status"],
      message: json["message"],
      totalResult: json["totalResult"],
      data: (json["data"] as List)
          .map((x) => RankingRL.fromJson(x))
          .toList(),
    );
  }

}

class RankingRL {
  final String? id;
  final String? customerName;
  final String? customerNumber;
  final double? point;
  final String? createdAt;
  final int? v;

  RankingRL({
    this.id,
    required this.customerName,
    required this.customerNumber,
    required this.point,
    required this.createdAt,
    required this.v,
  });

  factory RankingRL.fromJson(Map<String, dynamic> json) {
    return RankingRL(
      id: json["_id"],
      customerName: json["customer_name"],
      customerNumber: json["customer_number"],
      point: json["point"]?.toDouble(),
      createdAt: json['createdAt'],
      // createdAt: json["createdAt"] != null
      //     ? DateTime.parse(json["createdAt"])
      //     : DateTime(2000,01,01),
      v: json["__v"],
    );
  }

}
