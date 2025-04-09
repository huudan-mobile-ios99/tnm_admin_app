import 'package:tnm_app_slot_aft/model/hive/hive_loginModel.dart';
import 'package:tnm_app_slot_aft/model/loginModel.dart';



extension LoginModelConverter on LoginModel {
  HiveLoginModel toHiveModel() {
    return HiveLoginModel(
      status: status,
      message: message,
      data: data.toHiveModelData(),
    );
  }
}

extension LoginModelDataConverter on LoginModelData {
  HiveLoginModelData toHiveModelData() {
    return HiveLoginModelData(
      imageUrl: imageUrl,
      id: id,
      username: username,
      password: password,
      createdAt: createdAt,
      v: v,
      role: role,
    );
  }
}
extension HiveToLoginModelConverter on HiveLoginModel {
  LoginModel toLoginModel() {
    return LoginModel(
      status: status,
      message: message,
      data: data.toLoginModelData(),
    );
  }
}

extension HiveToLoginModelDataConverter on HiveLoginModelData {
  LoginModelData toLoginModelData() {
    return LoginModelData(
      imageUrl: imageUrl,
      id: id,
      username: username,
      password: password,
      createdAt: createdAt,
      v: v,
      role: role,
    );
  }
}
