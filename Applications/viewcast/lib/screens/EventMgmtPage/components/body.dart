import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/EventMgmtPage/components/list.dart';
import 'package:viewcast/screens/EventMgmtPage/components/pre_list.dart';
import 'package:viewcast/screens/components/column_row_item.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/styles.dart';

class Body extends StatelessWidget {
  final int flex;
  const Body({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: const [
          ExPadding(flex: 2),
          PreListRow(flex: 2),
          ExPadding(flex: 1),
          ColumnNameRow(flex: 2),
          ListRow(flex: 24),
          ExPadding(flex: 2),
        ],
      ),
    );
  }
}

class ColumnNameRow extends StatelessWidget {
  final int flex;
  const ColumnNameRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const ExPadding(flex: 1),
          Expanded(
            flex: 24,
            child: Container(
              width: double.infinity,
              height: 50,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: shadowBorder(8, 8, viewCastColor),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  const ColumnRowItem(label: "#", flex: 1),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventName,
                      flex: 2),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventDate,
                      flex: 2),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventDays,
                      flex: 3),
                  const ColumnRowItem(label: "", flex: 1),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventStartHour,
                      flex: 2),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventEndHour,
                      flex: 2),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventView,
                      flex: 2),
                  ColumnRowItem(
                      label: CustomLocalizations.of(context).eventFreq,
                      flex: 2),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.transparent),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.transparent),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.transparent),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}
