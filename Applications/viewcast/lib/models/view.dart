import 'package:viewcast/models/event.dart';
import 'package:viewcast/models/file.dart';

class View {
  int? id;
  String? name;
  List<Event>? eventsList;
  List<File>? filesList;
  int? filesCount;
  List<int>? filesIds;

  View(
      {this.id,
      this.name,
      this.eventsList,
      this.filesList,
      this.filesCount,
      this.filesIds});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'events_list': eventsList,
        'files_list': filesList,
        'files_ids': filesIds,
      };

  void fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];

    List<int> filesIdsTemp = [];
    if (o['files_ids'] != null) {
      o['files_ids'].forEach((item) {
        filesIdsTemp.add(item);
      });
    }

    filesIds = filesIdsTemp;

    filesCount = filesIds!.length;
    // eventsList = o['events_list'];
    // filesList = o['files_list'];
  }
}
