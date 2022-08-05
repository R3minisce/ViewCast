// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/services/api_config.dart';
import 'package:viewcast/services/user_service.dart';

class CastService {
  List<Cast> parseCasts(Uint8List responseBody) {
    List<Cast> casts = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (cast) {
        Cast temp = Cast();
        temp.fromJson(cast);
        casts.add(temp);
      },
    );
    return casts;
  }

  Future<List<Cast>> getCasts() async {
    var uri = Uri.http("$apiIP:$apiPort", castEndpoint);

    final response = await Client().get(uri);
    return parseCasts(response.bodyBytes);
  }

  Future<List<Cast>> getCastsByUser(String uuid) async {
    var uri = Uri.http("$apiIP:$apiPort", castEndpoint + "user/$uuid");

    final response = await Client().get(uri);
    return parseCasts(response.bodyBytes);
  }

  Future<Cast> getCast(int castId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$castEndpoint$castId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Cast cast = Cast();
    cast.fromJson(parsed);
    return cast;
  }

  static void notifyUpdateCast(int id) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$updateCastEndpoint$id');
    Client().get(uri);
  }

  static void notifyDeleteCast(int id) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$deleteCastEndpoint$id');
    Client().delete(uri);
  }

  static Future<Cast?> addCast(dynamic cast) async {
    var uri = Uri.http("$apiIP:$apiPort", castEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cast),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Cast castObj = Cast();
    castObj.fromJson(parsed);
    return castObj;
  }

  static Future<bool> updateCast(dynamic cast, int id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$castEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cast),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteCast(int castId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$castEndpoint$castId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) return false;
    return true;
  }
}

final castProvider = Provider((ref) => CastService());

final getCastsProvider = FutureProvider.autoDispose<List<Cast>>((ref) async {
  ref.watch(refreshCast);
  final castService = ref.read(castProvider);
  return await castService.getCasts();
});

final getCastsByNameProvider =
    FutureProvider.autoDispose.family<List<Cast>, String>((ref, uuid) async {
  ref.watch(refreshCast);
  final castService = ref.read(castProvider);
  return await castService.getCastsByUser(uuid);
});

final getCastProvider =
    FutureProvider.family.autoDispose<Cast, int>((ref, idCast) async {
  final castService = ref.read(castProvider);
  return await castService.getCast(idCast);
});

final searchCastProvider = StateProvider<String>((ref) => "");

final filteredCasts = FutureProvider.autoDispose<List<Cast>>((ref) async {
  final filter = ref.watch(searchCastProvider);
  final user = ref.watch(currentUserProvider).state;
  if (user != null) {
    var casts = (user.admin!)
        ? await ref.watch(getCastsProvider.future)
        : await ref.watch(getCastsByNameProvider.call(user.uuid!).future);
    return casts
        .where((cast) =>
            cast.name!.toLowerCase().contains(filter.state.toLowerCase()))
        .toList();
  }
  return [];
});

final refreshCast = StateProvider<int>((ref) => 0);

final editCast = StateProvider<bool>((ref) => false);
final selectedCast = StateProvider<Cast?>((ref) => null);

final conflictingEventsIds = StateProvider<List<int>>((ref) => []);
