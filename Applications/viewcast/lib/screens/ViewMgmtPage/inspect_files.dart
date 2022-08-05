import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/file.dart';

import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/searchbar.dart';
import 'package:viewcast/screens/ViewMgmtPage/file_inspection.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';

import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';

class PopUpFilesStruct extends StatelessWidget {
  const PopUpFilesStruct({
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
                    PopUpFilesBody(flex: 12),
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

class PopUpFilesBody extends StatelessWidget {
  final int flex;
  const PopUpFilesBody({
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
                var data = watch(selectedView.notifier).state;
                final filter = watch(searchFileProvider).state;
                List<File> filteredFiles = [];
                if (data != null) {
                  filteredFiles = data.filesList!
                      .where((file) => file.name!
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
                            .viewFilesName(data.name!),
                        searchProviders: [
                          searchFileProvider,
                        ],
                        editProvider: editView,
                        selectedProvider: selectedView,
                      ),
                      const ExPadding(flex: 1),
                      SearchBarRow(
                          flex: 2,
                          provider: searchFileProvider,
                          name: "search"),
                      const ExPadding(flex: 1),
                      FileInspectionRow(
                          flex: 18, data: data, files: filteredFiles),
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
