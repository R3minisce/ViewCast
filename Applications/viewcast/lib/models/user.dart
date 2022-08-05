import 'package:viewcast/models/group.dart';

class User {
  int? id;
  String? uuid;
  String? username;
  DateTime? creationTime;
  String? email;
  bool? admin;
  List<Group>? groups;

  User({
    this.id,
    this.uuid,
    this.username,
    this.creationTime,
    this.email,
    this.admin,
    this.groups,
  });

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'username': username,
        'email': email,
        'creation_time': creationTime,
        'admin': admin,
        'groups': groups,
      };

  void fromJson(dynamic o) {
    uuid = o['uuid'];
    username = o['username'];
    email = o['email'];
    creationTime = o['creation_time'];
    admin = o['admin'];
    List<Group> groupsTemp = [];
    if (o['groups'] != null) {
      o['groups'].forEach((item) {
        var temp = Group();
        temp.fromJson(item);

        groupsTemp.add(temp);
      });
    }

    groups = groupsTemp;
  }
}
