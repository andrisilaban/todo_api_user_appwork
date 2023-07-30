import 'package:flutter/material.dart';
import 'package:todo_api_user_appwork/models/user_model.dart';
import 'package:todo_api_user_appwork/services/user_services.dart';

class UserProvider extends ChangeNotifier {
  final userService = UserServices();
  bool isLoading = false;
  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;
  bool isInsert = false;
  bool isUpdate = false;
  bool isDelete = false;

  bool enableButtonInsert = true;
  bool enableButtonUpdate = true;
  bool enableButtonDelete = true;
  bool enableButtonRefresh = true;
  var textUser = UserModel(name: '', email: '');

  void reset() {
    textUser = UserModel(name: '', email: '');
    enableButtonInsert = true;
    notifyListeners();
  }

  Future<void> getUsers() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _userList = await userService.getUser();
    isLoading = false;
    notifyListeners();
  }

  Future<void> insertUser(UserModel user) async {
    isInsert = await userService.insertUser(
      user: user,
    );
    if (isInsert) {
      getUsers();
      reset();
    }
    notifyListeners();
  }

  Future<void> updateUser(UserModel user, String idUser) async {
    isLoading = true;
    notifyListeners();
    isUpdate = await userService.updateUser(
      user: user,
      idUser: idUser,
    );
    if (isUpdate) {
      getUsers();
      reset();
    }
  }

  Future<void> deleteUser({required idUser}) async {
    isLoading = true;
    notifyListeners();
    isDelete = await userService.deleteUser(idUser: idUser);
    if (isDelete) {
      getUsers();
      reset();
    }
  }

  void setEnabledButton() {
    enableButtonInsert = false;
    notifyListeners();
  }
}
