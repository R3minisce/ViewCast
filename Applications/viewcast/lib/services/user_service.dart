import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/services/api_config.dart';

class UserService {
  List<User> parseUsers(Uint8List responseBody) {
    List<User> users = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (user) {
        user['creation_time'] = DateTime.parse(user['creation_time']);
        User temp = User();
        temp.fromJson(user);
        users.add(temp);
      },
    );
    return users;
  }

  Future<List<User>> getUsers() async {
    var uri = Uri.http("$apiIP:$apiPort", userEndpoint);

    final response = await Client().get(uri);
    return parseUsers(response.bodyBytes);
  }

  Future<User> getUser(int userId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$userEndpoint$userId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    User user = User();
    user.fromJson(parsed);
    return user;
  }

  static Future<User?> addUser(var user) async {
    var uri = Uri.http("$apiIP:$apiPort", userEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    parsed['creation_time'] = DateTime.parse(parsed['creation_time']);
    User userObj = User();
    userObj.fromJson(parsed);
    return userObj;
  }

  static Future<bool> updateUser(var user, String id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$userEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteUser(String userUuid) async {
    var uri = Uri.http("$apiIP:$apiPort", '$userEndpoint$userUuid');
    Response response;
    try {
      response = await delete(uri);
    } on Exception catch (_) {
      return false;
    }
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<String?> getToken(String username, String password) async {
    var uri = Uri.http("$apiIP:$apiPort", loginEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body:
          "grant_type=&username=$username&password=$password&scope=me&client_id=&client_secret=",
    );
    if (response.statusCode != 200) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));

    var tokenType = 'Bearer';
    var tokenData = parsed['access_token'];

    var tokenString = "$tokenType $tokenData";
    return tokenString;
  }

  static Future<User?> login(String? token) async {
    var uri = Uri.http("$apiIP:$apiPort", loginEndpoint);
    if (token != null) {
      final Response response = await get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode != 200) return null;
      final parsed = jsonDecode(utf8.decode(response.bodyBytes));
      User user = User();
      user.fromJson(parsed);
      return user;
    }
    return null;
  }
}

final userProvider = Provider((ref) => UserService());

final getUsersProvider = FutureProvider<List<User>>((ref) async {
  ref.watch(refreshUser);
  final userService = ref.read(userProvider);
  return await userService.getUsers();
});

final getUserProvider =
    FutureProvider.family.autoDispose<User, int>((ref, idUser) async {
  final userService = ref.read(userProvider);
  return await userService.getUser(idUser);
});

// final getCurrentUser = FutureProvider.autoDispose<User?>((ref) async {
//   final userService = ref.read(userProvider);
//   return await userService.login();
// });

final searchUserProvider = StateProvider<String>((ref) => "");

final filteredUsers = FutureProvider.autoDispose<List<User>>((ref) async {
  final filter = ref.watch(searchUserProvider);
  final users = await ref.watch(getUsersProvider.future);
  return users
      .where((user) =>
          user.username!.toLowerCase().contains(filter.state.toLowerCase()))
      .toList();
});

final refreshUser = StateProvider<int>((ref) => 0);

final editUser = StateProvider<bool>((ref) => false);
final selectedUser = StateProvider<User?>((ref) => null);

final currentUserProvider = StateProvider<User?>((ref) => null);
