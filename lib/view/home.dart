import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api_user_appwork/constant/constant.dart';
import 'package:todo_api_user_appwork/models/user_model.dart';
import 'package:todo_api_user_appwork/provider/user_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email = '';
  String name = '';
  String idSelected = '';

  void insertUpdateUser({
    required BuildContext context,
    required String name,
    required String email,
    String? idSelected,
  }) {
    if (name.isNotEmpty && email.isNotEmpty) {
      bool valid = isValidEmail(email);
      if (valid) {
        UserProvider userProvider = context.read<UserProvider>();
        if (idSelected != null) {
          userProvider.updateUser(
              UserModel(name: name, email: email), idSelected);
          showSnackBar(context, 'Update Success');
        } else {
          userProvider.insertUser(UserModel(name: name, email: email));
          showSnackBar(context, 'Create Success');
        }
        reset();
      } else {
        showSnackBar(context, 'Email Format Not Valid');
      }
    } else {
      showSnackBar(context, 'Fill Valid Name And Email');
    }
  }

  void deleteUser(BuildContext context, String idSelected) {
    context.read<UserProvider>().deleteUser(idUser: idSelected);
    reset();
  }

  void reset() {
    name = '';
    email = '';
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool isValidEmail(String email) {
    const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      context.read<UserProvider>().getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO API USER'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(
                  text: context.watch<UserProvider>().textUser.name.isNotEmpty
                      ? context.watch<UserProvider>().textUser.name
                      : null,
                ),
                decoration: const InputDecoration(
                  hintText: 'name',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                controller: TextEditingController(
                  text: context.watch<UserProvider>().textUser.email.isNotEmpty
                      ? context.watch<UserProvider>().textUser.email
                      : null,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(hintText: 'email'),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          context.watch<UserProvider>().enableButtonInsert
                              ? () {
                                  insertUpdateUser(
                                    context: context,
                                    name: name,
                                    email: email,
                                  );
                                }
                              : null,
                      child: const Text('CREATE'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          context.watch<UserProvider>().enableButtonUpdate
                              ? () {
                                  insertUpdateUser(
                                      context: context,
                                      name: name,
                                      email: email,
                                      idSelected: idSelected);
                                }
                              : null,
                      child: const Text('UPDATE'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          context.watch<UserProvider>().enableButtonDelete
                              ? () {
                                  deleteUser(context, idSelected);
                                }
                              : null,
                      child: const Text('DELETE'),
                    ),
                  ),
                ],
              ),
              sh10,
              context.watch<UserProvider>().isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
              Expanded(
                child: ListView.builder(
                  itemCount: context.watch<UserProvider>().userList.length,
                  itemBuilder: (context, index) {
                    var userList =
                        context.watch<UserProvider>().userList[index];
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          idSelected = userList.id.toString();
                          name = userList.name;
                          email = userList.email;
                          context.read<UserProvider>().textUser = UserModel(
                              name: userList.name, email: userList.email);
                          context.read<UserProvider>().setEnabledButton();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: idSelected == userList.id.toString()
                                ? blueColor
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sh10,
                                Text(
                                  userList.id.toString(),
                                  style: idSelected == userList.id.toString()
                                      ? ts16White
                                      : ts16Black,
                                ),
                                sh10,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        userList.name,
                                        style:
                                            idSelected == userList.id.toString()
                                                ? ts16White
                                                : ts16Black,
                                      ),
                                      Text(
                                        userList.email,
                                        style:
                                            idSelected == userList.id.toString()
                                                ? ts16White
                                                : ts16Black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
