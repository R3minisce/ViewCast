// Colors Settings
import 'package:flutter/material.dart';
import 'package:viewcast/localization/l10n.dart';

Color baseColor = const Color(0XFF6B75AA);
Color shadowColor = const Color(0XFF5B6491); // Pourc = 8
Color lightColor = const Color(0XFF7783BE); //

Color viewCastColor = const Color.fromARGB(255, 0, 76, 143);
Color viewCastColorLight = const Color.fromARGB(255, 0, 115, 201);
Color viewCastColorDark = const Color.fromARGB(255, 4, 60, 102);
Color viewCastColorLighter = const Color.fromARGB(255, 231, 242, 247);
Color fakeViewCastColor = const Color.fromARGB(255, 30, 75, 140);

late List<String> kDays;

void setKDays(BuildContext context) {
  kDays = [
    CustomLocalizations.of(context).monday,
    CustomLocalizations.of(context).tuesday,
    CustomLocalizations.of(context).wednesday,
    CustomLocalizations.of(context).thursday,
    CustomLocalizations.of(context).friday,
    CustomLocalizations.of(context).saturday,
    CustomLocalizations.of(context).sunday,
  ];
}
