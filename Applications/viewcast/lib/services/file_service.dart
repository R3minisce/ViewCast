// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/file.dart';
import 'package:viewcast/services/api_config.dart';

class FileService {
  List<File> parseFiles(Uint8List responseBody) {
    List<File> files = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (file) {
        File temp = File();
        temp.fromJson(file);
        files.add(temp);
      },
    );
    return files;
  }

  Future<List<File>> getFiles() async {
    var uri = Uri.http("$apiIP:$apiPort", fileEndpoint);

    final response = await Client().get(uri);
    return parseFiles(response.bodyBytes);
  }

  Future<File> getFile(int fileId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$fileEndpoint$fileId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    File file = File();
    file.fromJson(parsed);
    return file;
  }

  static Future<File?> addFile(File file) async {
    var uri = Uri.http("$apiIP:$apiPort", fileEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(file),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    File fileObj = File();
    fileObj.fromJson(parsed);
    return fileObj;
  }

  Future<bool> updateFile(File file) async {
    var uri = Uri.http("$apiIP:$apiPort", '$fileEndpoint${file.id}');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(file),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteFile(int fileId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$fileEndpoint$fileId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    return true;
  }
}

final fileProvider = Provider((ref) => FileService());

final getFilesProvider = FutureProvider.autoDispose<List<File>>((ref) async {
  ref.watch(refreshFile); // necessary to update when a file is added / deleted
  final fileService = ref.read(fileProvider);
  var files = await fileService.getFiles();
  return files;
});

final getFileProvider =
    FutureProvider.family.autoDispose<File, int>((ref, idFile) async {
  final fileService = ref.read(fileProvider);
  return await fileService.getFile(idFile);
});

final updateFileProvider =
    FutureProvider.family.autoDispose<bool, File>((ref, file) async {
  final fileService = ref.read(fileProvider);
  return await fileService.updateFile(file);
});

final refreshFile = StateProvider<int>((ref) => 0);

final searchFileProvider = StateProvider<String>((ref) => "");

final filteredFiles = FutureProvider.autoDispose<List<File>>((ref) async {
  final filter = ref.watch(searchFileProvider);
  final files = await ref.watch(getFilesProvider.future);
  return files
      .where((file) =>
          file.name!.toLowerCase().contains(filter.state.toLowerCase()))
      .toList();
});

final filesBufferProvider = StateProvider<Map<int, File>>((ref) => {});
final filesBufferRecentId = StateProvider<int?>((ref) => null);

final filesBuffer = FutureProvider.autoDispose<Map<int, File>>((ref) async {
  final id = ref.watch(filesBufferRecentId).state;
  final files = ref.watch(filesBufferProvider).state;
  if (id != null && !files.containsKey(id)) {
    final file = await ref.watch(getFileProvider.call(id).future);
    if (files.length > 20) {
      files.remove(files.keys.first);
    }
    files[file.id!] = file;
  }
  return files;
});

final filesDashboardProvider = StateProvider<Map<int, File>>((ref) => {});
final castsDashboardRefreshProvider = StateProvider<int>((ref) => 0);
final castsDashboardProvider = StateProvider<Map<int, int>>((ref) => {});
