import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:viewcast/services/api_config.dart';
import 'package:viewcast/services/file_service.dart';

class SocketManager {
  static late io.Socket socket;
  String url = "http://$orchIP:$orchPortSocket";

  static final SocketManager _singleton = SocketManager._internal();

  factory SocketManager() {
    return _singleton;
  }

  SocketManager._internal();

  void connectToServer() {
    socket =
        io.io(url, io.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {});

    // connection lost to server
    socket.onDisconnect((_) => {});
  }

  void displayConnection(int displayId) {
    socket.emit("register", {"display_id": displayId});
  }

  void dashboardConnection() {
    socket.emit("register dashboard");
  }

  void startListening(BuildContext context) {
    socket.on(
      'load file',
      (data) async {
        if (data['dashboard'] != null && data['dashboard']) {
          Map<int, int> casts =
              Map.from(context.read(castsDashboardProvider.notifier).state);

          if (casts.containsKey(data['stream_id'])) {
            // modification
            if (data['file_id'] != null) {
              casts[data['stream_id']] = data['file_id'];
              await _handleFiles(context, data['file_id']);
              context.read(castsDashboardProvider.notifier).state = casts;
            }

            //suppression
            else {
              casts.remove(data['stream_id']);
              context.read(castsDashboardProvider.notifier).state = casts;
              context.read(castsDashboardRefreshProvider.notifier).state++;
            }
          }

          // création
          else {
            if (data['file_id'] != null) {
              casts[data['stream_id']] = data['file_id'];
              await _handleFiles(context, data['file_id']);
              context.read(castsDashboardProvider.notifier).state = casts;
              context.read(castsDashboardRefreshProvider.notifier).state++;
            }
          }
        } else {
          context.read(filesBufferRecentId.notifier).state = data['file_id'];
        }
      },
    );
  }

  _handleFiles(BuildContext context, int fileId) async {
    var files = Map.of(context.read(filesDashboardProvider.notifier).state);

    if (!files.containsKey(fileId)) {
      final file = await context.read(getFileProvider.call(fileId).future);
      if (files.length > 50) {
        files.remove(files.keys.first);
      }
      files[file.id!] = file;

      context.read(filesDashboardProvider.notifier).state = files;
    }
  }

  void logout(BuildContext context) {
    socket.emit('logout');
    socket.off('load file');
    context.read(filesBufferRecentId.notifier).state = null;
  }
}
