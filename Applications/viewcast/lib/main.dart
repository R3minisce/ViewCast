import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/screens/CastMgmtPage/cast_mgmt.dart';
import 'package:viewcast/screens/CastingPage/casting_main.dart';
import 'package:viewcast/screens/ConnectPage/connect_main.dart';
import 'package:viewcast/screens/DisplayMgmtPage/display_mgmt.dart';
import 'package:viewcast/screens/EventMgmtPage/event_mgmt.dart';
import 'package:viewcast/screens/LivePage/live_main.dart';
import 'package:viewcast/screens/UserMgmtPage/user_mgmt.dart';
import 'package:viewcast/screens/GroupMgmtPage/group_mgmt.dart';
import 'package:viewcast/screens/ViewMgmtPage/view_mgmt.dart';
import 'package:viewcast/styles.dart';

import 'screens/AuthPage/auth_main.dart';

var routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const ConnectPage(),
  "/signin": (BuildContext context) => const AuthPage(),
  "/casting": (BuildContext context) => const CastingPage(),
  //"/dashboard": (BuildContext context) => const DashboardPage(),
  "/live": (BuildContext context) => const LivePage(),
  "/usermgmt": (BuildContext context) => const UserMgmtPage(),
  "/groupmgmt": (BuildContext context) => const GroupMgmtPage(),
  "/viewmgmt": (BuildContext context) => const ViewMgmtPage(),
  "/eventmgmt": (BuildContext context) => const EventMgmtPage(),
  "/castmgmt": (BuildContext context) => const CastMgmtPage(),
  "/displaymgmt": (BuildContext context) => const DisplayMgmtPage(),
};

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Consumer(
      builder: (context, watch, child) {
        var locale = watch(localeProvider).state;
        locale ??= 'en';

        return MaterialApp(
          title: 'ViewCast',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: viewCastColor,
              textTheme: GoogleFonts.montserratTextTheme(),
              primarySwatch: Colors.blue,
              brightness: Brightness.light),
          initialRoute: '/',
          routes: routes,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            CustomLocalizations.delegate,
          ],
          locale: Locale(locale),
          supportedLocales: const [Locale('en'), Locale('nl'), Locale('fr')],
          scrollBehavior: MyCustomScrollBehavior(),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
