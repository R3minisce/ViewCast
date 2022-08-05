import 'package:viewcast/styles.dart';

class Event {
  int? id;
  String? name;
  String? specificDate;
  DateTime? specificDateDateTime;
  String? startHour;
  double? startHourDouble;
  String? endHour;
  double? endHourDouble;
  List<String>? days;
  int? timer;
  int? castId;
  int? topicId;

  Event({
    this.id,
    this.name,
    this.timer,
    this.specificDate,
    this.specificDateDateTime,
    this.startHour,
    this.endHour,
    this.days,
    this.startHourDouble,
    this.endHourDouble,
    this.castId,
    this.topicId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specific_date': specificDate,
        'start_hour': startHour,
        'end_hour': endHour,
        'days': days,
        'timer': timer,
        'stream_id': castId,
        'topic_id': topicId
      };

  void fromJson(dynamic o) {
    id = o['id'];
    name = o['name'];
    specificDate = o['specific_date'];
    startHour = o['start_hour'];
    endHour = o['end_hour'];
    timer = o['timer'];
    topicId = o['topic_id'];
    castId = o['stream_id'];
    String? days = o['days'];

    var sHour = startHour!.split(':')[0];
    var sMin = startHour!.split(':')[1];
    var eHour = endHour!.split(':')[0];
    var eMin = endHour!.split(':')[1];

    startHourDouble = int.parse(sHour) + int.parse(sMin) / 60;
    endHourDouble = int.parse(eHour) + int.parse(eMin) / 60;

    if (specificDate != null) specificDateDateTime = _specificDateToDateTime();

    List<String> res = [];
    int i = 0;
    if (days != null) {
      days.split("").forEach((element) {
        if (element == "1") {
          res.add(kDays[i]);
        }
        i++;
      });
    }
    this.days = res;
  }

  DateTime _specificDateToDateTime() {
    var year = specificDate!.split('-')[0];
    var month = specificDate!.split('-')[1];
    var day = specificDate!.split('-')[2];

    return DateTime(int.parse(year), int.parse(month), int.parse(day));
  }
}
