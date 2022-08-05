// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/services/api_config.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/services/user_service.dart';

class DisplayService {
  List<Display> parseDisplays(Uint8List responseBody) {
    List<Display> displays = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (display) {
        display['creation_time'] = DateTime.parse(display['creation_time']);
        Display temp = Display();
        temp.fromJson(display);
        displays.add(temp);
      },
    );
    return displays;
  }

  Future<List<Display>> getDisplays() async {
    var uri = Uri.http("$apiIP:$apiPort", displayEndpoint);

    final response = await Client().get(uri);
    return parseDisplays(response.bodyBytes);
  }

  Future<List<Display>> getDisplaysByUser(String uuid) async {
    var uri = Uri.http("$apiIP:$apiPort", displayEndpoint + "user/$uuid");

    final response = await Client().get(uri);

    return parseDisplays(response.bodyBytes);
  }

  Future<List<Display>> getDisplaysWithoutGroup() async {
    var uri = Uri.http("$apiIP:$apiPort", displayEndpoint + "available");

    final response = await Client().get(uri);
    return parseDisplays(response.bodyBytes);
  }

  Future<Display> getDisplay(int displayId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$displayEndpoint$displayId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Display display = Display();
    display.fromJson(parsed);
    return display;
  }

  static void notifyUpdateDisplay(int id) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$updateDisplayEndpoint$id');
    Client().get(uri);
  }

  static void notifyDeleteDisplay(int id) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$deleteDisplayEndpoint$id');
    Client().delete(uri);
  }

  static Future<Display?> getDisplayByName(String displayName) async {
    var uri =
        Uri.http("$apiIP:$apiPort", displayEndpoint + "name/" + displayName);
    final response = await Client().get(uri);
    if (response.statusCode != 200) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    parsed['creation_time'] = DateTime.parse(parsed['creation_time']);
    Display display = Display();
    display.fromJson(parsed);
    return display;
  }

  static Future<Display?> addDisplay(dynamic display) async {
    var uri = Uri.http("$apiIP:$apiPort", displayEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(display),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Display displayObj = Display();
    parsed['creation_time'] = DateTime.parse(parsed['creation_time']);
    displayObj.fromJson(parsed);
    return displayObj;
  }

  static Future<bool> updateDisplay(dynamic display, int id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$displayEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(display),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteDisplay(int displayId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$displayEndpoint$displayId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    return true;
  }
}

final displayProvider = Provider((ref) => DisplayService());

final getDisplaysProvider =
    FutureProvider.autoDispose<List<Display>>((ref) async {
  ref.watch(refreshDisplay);
  final displayService = ref.read(displayProvider);
  return await displayService.getDisplays();
});

final getDisplaysByUserProvider =
    FutureProvider.family.autoDispose<List<Display>, String>((ref, uuid) async {
  ref.watch(refreshDisplay);
  final displayService = ref.read(displayProvider);
  return await displayService.getDisplaysByUser(uuid);
});

final getDisplaysWithoutGroupProvider =
    FutureProvider.autoDispose<List<Display>>((ref) async {
  ref.watch(refreshDisplay);
  final displayService = ref.read(displayProvider);
  return await displayService.getDisplaysWithoutGroup();
});

final getDisplayProvider =
    FutureProvider.family.autoDispose<Display, int>((ref, idDisplay) async {
  ref.watch(refreshDisplay);
  final displayService = ref.read(displayProvider);
  return await displayService.getDisplay(idDisplay);
});

final searchDisplayProvider = StateProvider<String>((ref) => "");

final filteredDisplays = FutureProvider.autoDispose<List<Display>>((ref) async {
  final filter = ref.watch(searchDisplayProvider);
  final user = ref.watch(currentUserProvider).state;
  if (user != null) {
    final displays = (user.admin!)
        ? await ref.watch(getDisplaysProvider.future)
        : await ref.watch(getDisplaysByUserProvider.call(user.uuid!).future) +
            await ref.watch(getDisplaysWithoutGroupProvider.future);
    return displays
        .where((display) =>
            display.name!.toLowerCase().contains(filter.state.toLowerCase()))
        .toList();
  }
  return [];
});

final filteredGrouplessDisplays =
    FutureProvider.autoDispose<List<Display>>((ref) async {
  final filter = ref.watch(searchDisplayProvider);
  final displays = await ref.watch(getDisplaysWithoutGroupProvider.future);
  final group = ref.watch(selectedGroup).state;
  if (group != null &&
      (group.displayList!.isEmpty ||
          !displays.contains(group.displayList![0]))) {
    displays.addAll(group.displayList!);
  }
  return displays
      .where((display) =>
          display.name!.toLowerCase().contains(filter.state.toLowerCase()))
      .toList();
});

final refreshDisplay = StateProvider<int>((ref) => 0);
final editDisplay = StateProvider<bool>((ref) => false);
final selectedDisplay = StateProvider<Display?>((ref) => null);
