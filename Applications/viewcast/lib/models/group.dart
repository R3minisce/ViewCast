import 'package:viewcast/models/display.dart';

class Group {
  int? id;
  String? name;
  String? description;
  int? streamId;
  List<Display>? displayList;
  int? displaysCount;

  Group(
      {this.id,
      this.name,
      this.description,
      this.displayList,
      this.streamId,
      this.displaysCount});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'display_list': displayList,
        'stream_id': streamId,
      };

  void fromJson(dynamic o) {
    List<Display> displays = [];
    if (o['displays'] != null) {
      o['displays'].forEach((elem) {
        elem['creation_time'] = DateTime.parse(elem['creation_time']);
        var temp = Display();
        temp.fromJson(elem);
        displays.add(temp);
      });
    }
    id = o['id'];
    description = o['description'];
    name = o['name'];
    displayList = displays;
    streamId = o['stream_id'];
    displaysCount = o['displays_count'];
  }
}
