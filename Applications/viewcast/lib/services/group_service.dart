// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/models/group.dart';
import 'package:viewcast/services/api_config.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/user_service.dart';

class GroupService {
  List<Group> parseGroups(Uint8List responseBody) {
    List<Group> groups = [];
    var response = jsonDecode(utf8.decode(responseBody));
    response.forEach(
      (group) {
        Group temp = Group();
        temp.fromJson(group);
        groups.add(temp);
      },
    );
    return groups;
  }

  Future<List<Group>> getGroups() async {
    var uri = Uri.http("$apiIP:$apiPort", groupEndpoint);

    final response = await Client().get(uri);
    return parseGroups(response.bodyBytes);
  }

  Future<List<Group>> getGroupsByUser(String uuid) async {
    var uri = Uri.http("$apiIP:$apiPort", groupEndpoint + "user/$uuid");

    final response = await Client().get(uri);
    return parseGroups(response.bodyBytes);
  }

  Future<List<Group>> getGroupsAvailable() async {
    var uri = Uri.http("$apiIP:$apiPort", groupEndpoint + "available");

    final response = await Client().get(uri);
    return parseGroups(response.bodyBytes);
  }

  Future<Group> getGroup(int groupId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$groupEndpoint$groupId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Group group = Group();
    group.fromJson(parsed);
    return group;
  }

  static void notifyDeleteGroup(int groupId) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$deleteGroupEndpoint$groupId');
    Client().delete(uri);
  }

  static Future<Group?> addGroup(String name, List<int> displaysIds) async {
    var uri = Uri.http("$apiIP:$apiPort", groupEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"name": name, "displays_ids": displaysIds}),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Group groupObj = Group();
    groupObj.fromJson(parsed);
    return groupObj;
  }

  static Future<bool> updateGroup(dynamic group, int id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$groupEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(group),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteGroup(int groupId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$groupEndpoint$groupId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    return true;
  }
}

final groupProvider = Provider((ref) => GroupService());

final getGroupsProvider = FutureProvider.autoDispose<List<Group>>((ref) async {
  ref.watch(refreshGroup);
  final groupService = ref.read(groupProvider);
  return await groupService.getGroups();
});

final getGroupsByUserProvider =
    FutureProvider.family.autoDispose<List<Group>, String>((ref, uuid) async {
  ref.watch(refreshGroup);
  final groupService = ref.read(groupProvider);
  return await groupService.getGroupsByUser(uuid);
});

final getGroupsAvailableProvider =
    FutureProvider.autoDispose<List<Group>>((ref) async {
  ref.watch(refreshGroup);
  final groupService = ref.read(groupProvider);
  return await groupService.getGroupsAvailable();
});

final getGroupProvider =
    FutureProvider.family.autoDispose<Group, int>((ref, idGroup) async {
  final groupService = ref.read(groupProvider);
  return await groupService.getGroup(idGroup);
});

final filteredGroups = FutureProvider.autoDispose<List<Group>>((ref) async {
  final filter = ref.watch(searchGroupProvider);
  final user = ref.watch(currentUserProvider).state;
  if (user != null) {
    final groups = (user.admin!)
        ? await ref.watch(getGroupsProvider.future)
        : await ref.watch(getGroupsByUserProvider.call(user.uuid!).future);

    return groups
        .where((group) =>
            group.name!.toLowerCase().contains(filter.state.toLowerCase()))
        .toList();
  }
  return [];
});

final searchGroupProvider = StateProvider<String>((ref) => "");
final refreshGroup = StateProvider<int>((ref) => 0);
final editGroup = StateProvider<bool>((ref) => false);
final selectedGroup = StateProvider<Group?>((ref) => null);

final filteredAvailableGroups =
    FutureProvider.autoDispose<List<Group>>((ref) async {
  final filter = ref.watch(searchGroupProvider);
  final user = ref.watch(currentUserProvider).state;
  if (user != null) {
    var groups = (user.admin!)
        ? await ref.watch(getGroupsAvailableProvider.future)
        : await ref.watch(filteredGroups.future);

    groups = groups.where((element) => element.streamId == null).toList();

    final cast = ref.watch(selectedCast);
    if (cast.state != null) {
      Cast castFull =
          await ref.watch(getCastProvider.call(cast.state!.id!).future);
      if (castFull.groups!.isEmpty ||
          !groups.contains(castFull.groups!.first)) {
        groups.addAll(castFull.groups!.toList());
      }
    }

    return groups
        .where((group) =>
            group.name!.toLowerCase().contains(filter.state.toLowerCase()))
        .toList();
  }
  return [];
});
