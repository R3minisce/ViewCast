import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/GroupMgmtPage/components/buttons.dart';
import 'package:viewcast/screens/GroupMgmtPage/components/searchbar.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/user_service.dart';

class PreListRow extends StatelessWidget {
  final int flex;

  const PreListRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          ExPadding(flex: 1),
          ActionRow(flex: 24),
          ExPadding(flex: 1),
        ],
      ),
    );
  }
}

/* Action flex here */

class ActionRow extends StatelessWidget {
  final int flex;
  const ActionRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.read(currentUserProvider).state;
    bool isLogged = (user != null);
    return Expanded(
      flex: flex,
      child: Flex(direction: Axis.horizontal, children: [
        const SearchBarRow(flex: 2),
        ExPadding(flex: (isLogged && user.admin!) ? 5 : 4),
        if (isLogged && user.admin!) const ButtonRow(flex: 1),
      ]),
    );
  }
}
