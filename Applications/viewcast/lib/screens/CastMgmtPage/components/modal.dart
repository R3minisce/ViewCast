import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';

import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/form_rows.dart';
import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/group_selection.dart';
import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/event_selection.dart';

import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/searchbar.dart';
import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/validation.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/event_service.dart';
import 'package:viewcast/services/group_service.dart';

class ModalStruct extends StatelessWidget {
  const ModalStruct({
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
                  children: [
                    const ExPadding(flex: 3),
                    ModalBody(flex: 24),
                    const ExPadding(flex: 3),
                  ],
                )),
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
            Expanded(
              flex: 30,
              child: Consumer(
                builder: (context, watch, child) {
                  var editionMode = watch(editCast).state;
                  var data = watch(selectedCast).state;
                  return FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        const ExPadding(flex: 1),
                        TitleRow(
                          flex: 2,
                          label: (!editionMode)
                              ? CustomLocalizations.of(context).createCast
                              : "${CustomLocalizations.of(context).edit} ${data!.name}",
                          searchProviders: [
                            searchGroupProvider,
                            searchEventProvider
                          ],
                          editProvider: editCast,
                          selectedProvider: selectedCast,
                        ),
                        const ExPadding(flex: 1),
                        LabelRow(flex: 2, data: data),
                        Expanded(
                          flex: 17,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 16.0),
                                          child: Text(
                                              CustomLocalizations.of(context)
                                                  .selectEvent,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      SearchBarRow(
                                          flex: 1,
                                          provider: searchEventProvider,
                                          name: "search1"),
                                      EventSelectionRow(flex: 6, data: data),
                                    ]),
                              ),
                              const ExPadding(flex: 1),
                              Expanded(
                                flex: 5,
                                child: Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 16.0),
                                          child: Text(
                                              CustomLocalizations.of(context)
                                                  .selectGroup,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      SearchBarRow(
                                          flex: 1,
                                          provider: searchGroupProvider,
                                          name: "search2"),
                                      GroupSelectionRow(flex: 6, data: data),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        ValidationRow(flex: 2, formKey: _formKey),
                        const ExPadding(flex: 1),
                      ],
                    ),
                  );
                },
              ),
            ),
            const ExPadding(flex: 1),
          ],
        ),
      ),
    );
  }
}
