import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/services/event_service.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/services/socket_manager.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/services/view_service.dart';
import 'package:viewcast/styles.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read(currentUserProvider).state;
    return Expanded(
      flex: 6,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          // NavBarItem(
          //     label: CustomLocalizations.of(context).navDashboard,
          //     route: "/dashboard"),
          NavBarItem(
              label: CustomLocalizations.of(context).navLives, route: "/live"),
          NavBarItem(
              label: CustomLocalizations.of(context).navDisplays,
              route: "/displaymgmt"),
          NavBarItem(
              label: CustomLocalizations.of(context).navGroups,
              route: "/groupmgmt"),
          if (user != null && user.admin!)
            NavBarItem(
                label: CustomLocalizations.of(context).navUsers,
                route: "/usermgmt"),
          NavBarItem(
              label: CustomLocalizations.of(context).navViews,
              route: "/viewmgmt"),
          NavBarItem(
              label: CustomLocalizations.of(context).navEvents,
              route: "/eventmgmt"),
          NavBarItem(
              label: CustomLocalizations.of(context).navCasts,
              route: "/castmgmt"),
          DisconnectItem(
              label: CustomLocalizations.of(context).navDisconnect,
              route: "/signin"),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String label;
  final String route;

  const NavBarItem({
    Key? key,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentPage = ModalRoute.of(context)!.settings.name == route;
    return Expanded(
      child: Container(
        color: isCurrentPage ? viewCastColor : Colors.transparent,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(22.0),
        child: InkWell(
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: isCurrentPage ? Colors.white : Colors.black)),
          ),
          onTap: () {
            if (ModalRoute.of(context)!.settings.name == "/live") {
              context.read(castsDashboardProvider.notifier).state = {};
              SocketManager().logout(context);
            }
            if (!isCurrentPage) {
              _refreshCorrectList(route, context);
              Navigator.pushReplacementNamed(context, route);
            }
          },
        ),
      ),
    );
  }

  void _refreshCorrectList(String route, BuildContext context) {
    switch (route) {
      case '/displaymgmt':
        context.read(refreshDisplay.notifier).state++;
        break;
      case '/groupmgmt':
        context.read(refreshGroup.notifier).state++;
        break;
      case '/usermgmt':
        context.read(refreshUser.notifier).state++;
        break;
      case '/viewmgmt':
        context.read(refreshView.notifier).state++;
        break;
      case '/eventmgmt':
        context.read(refreshEvent.notifier).state++;
        break;
      case '/castmgmt':
        context.read(refreshCast.notifier).state++;
        break;
      default:
        break;
    }
  }
}

class DisconnectItem extends StatelessWidget {
  final String label;
  final String route;

  const DisconnectItem({
    Key? key,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Text(label, style: const TextStyle(color: Colors.red)),
          ),
          onTap: () {
            context.read(currentUserProvider.notifier).state = null;
            if (ModalRoute.of(context)!.settings.name == "/live") {
              context.read(castsDashboardProvider.notifier).state = {};
              SocketManager().logout(context);
            }
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }
}
