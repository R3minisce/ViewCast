import 'dart:convert';

import 'dart:typed_data';

class File {
  int? id;
  Uint8List? bytes;
  String? bytesString;
  String? name;
  String? type;
  int? order;

  File(
      {this.id,
      this.bytes,
      this.name,
      this.type,
      this.order,
      this.bytesString});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'bytes': bytesString,
        'type': type,
      };

  void fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];
    String bytesList = o['bytes'];
    bytes = base64.decode(bytesList);
    type = o['type'];
  }
}
