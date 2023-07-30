import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_api_user_appwork/models/get_response.dart';
import 'package:todo_api_user_appwork/models/user_model.dart';

class UserServices {
  final baseUrl = 'https://capekngoding.com/62895387265666/api/users';
  Dio dio = Dio();

  Future<List<UserModel>> getUser() async {
    List<UserModel> userList = [];
    try {
      final response = await dio.get('$baseUrl?*');
      GetResponse getResponse = GetResponse(response.data);
      if (getResponse.getData != null) {
        final List dataList = getResponse.getData;
        userList = dataList.map((user) => UserModel.fromJson(user)).toList();
        return userList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userList;
  }

  Future<bool> insertUser({required UserModel user}) async {
    try {
      debugPrint('users ${user.toString()}');
      Response response = await dio.post('$baseUrl?*',
          data: user,
          options: Options(
            headers: {"Content-Type": "application/json"},
          ));
      GetResponse getResponse = GetResponse(response.data);
      if (getResponse.module.isNotEmpty) {
        log('module ${getResponse.module}');
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> updateUser(
      {required UserModel user, required String idUser}) async {
    try {
      debugPrint(user.toString());
      Response response = await dio.post('$baseUrl/$idUser',
          data: user,
          options: Options(
            headers: {"Content-Type": "application/json"},
          ));

      GetResponse getResponse = GetResponse(response.data);
      if (getResponse.getData != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> deleteUser({required String idUser}) async {
    try {
      Response response = await dio.delete('$baseUrl/$idUser');
      GetResponse getResponse = GetResponse(response.data);
      if (getResponse.message != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
