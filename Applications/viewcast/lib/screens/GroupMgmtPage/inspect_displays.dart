import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';

import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/searchbar.dart';
import 'package:viewcast/screens/GroupMgmtPage/display_inspection.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/services/group_service.dart';

class PopUpDisplaysStruct extends StatelessWidget {
  const PopUpDisplaysStruct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Flex(
        direction: Axis.vertical,
        children: [
          const ExPadding(flex: 1),
          Expanded(
            flex: 28,
            child: Container(
                color: Colors.transparent,
                child: Flex(
                  direction: Axis.horizontal,
                  children: const [
                    ExPadding(flex: 3),
                    PopUpDisplaysBody(flex: 12),
                    ExPadding(flex: 3),
                  ],
                )),
          ),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class PopUpDisplaysBody extends StatelessWidget {
  final int flex;
  const PopUpDisplaysBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: shadowBorder(16, 16, Colors.white.withOpacity(0.9)),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            const ExPadding(flex: 1),
            Expanded(
              flex: 30,
              child: Consumer(builder: (context, watch, child) {
                var data = watch(selectedGroup.notifier).state;
                final filter = watch(searchDisplayProvider).state;
                List<Display> filteredDisplays = [];
                if (data != null) {
                  filteredDisplays = data.displayList!
                      .where((display) => display.name!
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .toList();
                }
                if (data != null) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      const ExPadding(flex: 1),
                      TitleRow(
                        flex: 2,
                        label: CustomLocalizations.of(context)
                            .groupDisplayName(data.name!),
                        searchProviders: [
                          searchDisplayProvider,
                        ],
                        editProvider: editGroup,
                        selectedProvider: selectedGroup,
                      ),
                      const ExPadding(flex: 1),
                      SearchBarRow(
                          flex: 2,
                          provider: searchDisplayProvider,
                          name: "search"),
                      const ExPadding(flex: 1),
                      DisplayInspectionRow(
                          flex: 18, data: data, displays: filteredDisplays),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            ),
            const ExPadding(flex: 1),
          ],
        ),
      ),
    );
  }
}
