import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/CastMgmtPage/components/modal.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/styles.dart';

class ButtonRow extends StatelessWidget {
  final int flex;

  const ButtonRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ActionButton(
        label: CustomLocalizations.of(context).create,
        textColor: Colors.white,
        borderFunc: shadowBorder(32, 32, viewCastColor),
        onPressed: () => _openPopup(context),
      ),
    );
  }

  void _openPopup(BuildContext context) {
    context.read(searchGroupProvider).state = "";
    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }
}
