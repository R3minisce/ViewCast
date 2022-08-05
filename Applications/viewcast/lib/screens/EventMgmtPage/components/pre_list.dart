import 'package:flutter/material.dart';
import 'package:viewcast/screens/EventMgmtPage/components/buttons.dart';
import 'package:viewcast/screens/EventMgmtPage/components/searchbar.dart';
import 'package:viewcast/screens/components/ex_padding.dart';

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
    return Expanded(
      flex: flex,
      child: Flex(direction: Axis.horizontal, children: const [
        SearchBarRow(flex: 2),
        ExPadding(flex: 4),
        ButtonRow(flex: 1),
      ]),
    );
  }
}
