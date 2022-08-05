class Display {
  int? id;
  String? name;
  int? groupId;
  DateTime? creationTime;

  Display({this.id, this.creationTime, this.name, this.groupId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'creation_time': creationTime,
        'name': name,
        'group_id': groupId,
      };

  void fromJson(dynamic o) {
    id = o['id'];
    creationTime = o['creation_time'];
    name = o['name'];
    groupId = o['group_id'];
  }

  // cast(dynamic o) {
  //   id = o.id;
  //   creationTime = o.creation_time;
  //   name = o.name;
  //   groupId = o.group_id;
  // }
}
