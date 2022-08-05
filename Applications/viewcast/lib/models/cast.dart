import 'package:viewcast/models/event.dart';
import 'package:viewcast/models/group.dart';

class Cast {
  int? id;
  String? name;
  List<Group>? groups;
  List<Event>? events;
  List<int>? groupsIds;
  List<int>? eventsIds;

  Cast(
      {this.id,
      this.name,
      this.groups,
      this.events,
      this.groupsIds,
      this.eventsIds});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'groups_list': groups,
        'events_list': events,
        'groups_ids': groupsIds,
        'events_ids': eventsIds,
      };

  void fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];
    groups = [];
    events = [];
    eventsIds = [];
    groupsIds = [];

    if (o['groups'] != null) {
      o['groups'].forEach((elem) {
        var temp = Group();
        temp.fromJson(elem);
        groups!.add(temp);
      });
    }

    if (o['events'] != null) {
      o['events'].forEach((elem) {
        var temp = Event();
        temp.fromJson(elem);
        events!.add(temp);
      });
    }

    if (o['groups_ids'] != null) {
      o['groups_ids'].forEach((item) {
        groupsIds!.add(item);
      });
    }

    if (o['events_ids'] != null) {
      o['events_ids'].forEach((item) {
        eventsIds!.add(item);
      });
    }
  }
}
