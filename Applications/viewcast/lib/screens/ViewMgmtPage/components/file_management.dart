import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/ViewMgmtPage/components/ModalItems/form_rows.dart';
import 'package:viewcast/screens/ViewMgmtPage/components/ModalItems/picture_grid_management.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';

class ModalFileStruct extends StatelessWidget {
  const ModalFileStruct({
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
            flex: 16,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const ExPadding(flex: 2),
                ModalBody(flex: 10),
                const ExPadding(flex: 2),
              ],
            ),
          ),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class ModalBody extends StatelessWidget {
  final int flex;
  ModalBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
            Consumer(
              builder: (context, watch, child) {
                return FormBuilder(
                  key: _formKey,
                  child: Expanded(
                    flex: 30,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        const ExPadding(flex: 1),
                        TitleRow(
                            flex: 2,
                            label: CustomLocalizations.of(context).manageFiles,
                            searchProviders: [searchFileProvider],
                            editProvider: editView,
                            selectedProvider: selectedView),
                        const ExPadding(flex: 1),
                        const SearchRow(flex: 2),
                        const ExPadding(flex: 1),
                        const GridStruct(flex: 23),
                        const ExPadding(flex: 1),
                      ],
                    ),
                  ),
                );
              },
            ),
            const ExPadding(flex: 1),
          ],
        ),
      ),
    );
  }
}
