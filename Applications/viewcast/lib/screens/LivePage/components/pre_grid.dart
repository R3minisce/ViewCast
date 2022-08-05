import 'package:flutter/material.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/components/ex_padding.dart';

class PreGridRow extends StatelessWidget {
  final int flex;

  const PreGridRow({
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
      child: Flex(direction: Axis.horizontal, children: [
        Expanded(
          flex: 2,
          child: Text(
            CustomLocalizations.of(context).currentLives,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const ExPadding(flex: 5),
      ]),
    );
  }
}
