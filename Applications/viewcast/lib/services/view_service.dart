// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/file.dart';
import 'package:viewcast/models/view.dart';
import 'package:viewcast/services/api_config.dart';

class ViewService {
  List<View> parseViews(Uint8List responseBody) {
    List<View> views = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (view) {
        View temp = View();
        temp.fromJson(view);
        views.add(temp);
      },
    );
    return views;
  }

  Future<List<View>> getViews() async {
    var uri = Uri.http("$apiIP:$apiPort", viewEndpoint);

    final response = await Client().get(uri);
    return parseViews(response.bodyBytes);
  }

  Future<View> getView(int viewId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$viewEndpoint$viewId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    View view = View();
    view.fromJson(parsed);
    return view;
  }

  static void notifyUpdateView(int viewId) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$updateViewEndpoint$viewId');
    Client().get(uri);
  }

  static void notifyDeleteView(int viewId) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$deleteViewEndpoint$viewId');
    Client().delete(uri);
  }

  Future<View> getViewWithFiles(int viewId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$viewEndpoint$viewId/files');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    View view = View();
    view.fromJson(parsed);
    view.filesList = [];
    for (var file in parsed['files']) {
      File newFile = File();
      newFile.fromJson(file);
      view.filesList!.add(newFile);
    }
    return view;
  }

  static Future<View?> addView(dynamic data) async {
    var uri = Uri.http("$apiIP:$apiPort", viewEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    View viewObj = View();
    viewObj.fromJson(parsed);
    return viewObj;
  }

  static Future<bool> updateView(dynamic view, int id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$viewEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(view),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteView(int viewId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$viewEndpoint$viewId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    return true;
  }
}

final viewProvider = Provider((ref) => ViewService());

final getViewsProvider = FutureProvider.autoDispose<List<View>>((ref) async {
  ref.watch(refreshView);
  final viewService = ref.read(viewProvider);
  return await viewService.getViews();
});

final getViewProvider =
    FutureProvider.family.autoDispose<View, int>((ref, idView) async {
  final viewService = ref.read(viewProvider);
  return await viewService.getView(idView);
});

final getViewWithFilesProvider =
    FutureProvider.autoDispose.family<View, int>((ref, id) async {
  final viewService = ref.read(viewProvider);
  return await viewService.getViewWithFiles(id);
});

final refreshView = StateProvider<int>((ref) => 0);

final searchViewProvider = StateProvider<String>((ref) => "");

final filteredViews = FutureProvider.autoDispose<List<View>>((ref) async {
  final filter = ref.watch(searchViewProvider);
  final views = await ref.watch(getViewsProvider.future);
  return views
      .where((view) =>
          view.name!.toLowerCase().contains(filter.state.toLowerCase()))
      .toList();
});

final editView = StateProvider<bool>((ref) => false);
final selectedView = StateProvider<View?>((ref) => null);
