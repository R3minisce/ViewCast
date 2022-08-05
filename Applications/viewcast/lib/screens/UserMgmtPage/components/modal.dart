import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/icon_button.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/UserMgmtPage/components/ModalItems/group_selection.dart';
import 'package:viewcast/screens/UserMgmtPage/components/ModalItems/password.dart';
import 'package:viewcast/screens/UserMgmtPage/components/ModalItems/profil.dart';
import 'package:viewcast/screens/UserMgmtPage/components/ModalItems/searchbar.dart';
import 'package:viewcast/screens/UserMgmtPage/components/ModalItems/validation.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/styles.dart';

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
                    ModalBody(flex: 8),
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
                  var editionMode = watch(editUser.notifier).state;
                  var data = watch(selectedUser.notifier).state;
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
                                ? CustomLocalizations.of(context).createUser
                                : CustomLocalizations.of(context)
                                    .editUser(data!.username!),
                            searchProviders: [searchGroupProvider],
                            editProvider: editUser,
                            selectedProvider: selectedUser),
                        const ExPadding(flex: 1),
                        Expanded(
                          flex: !editionMode ? 6 : 2,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              if (!editionMode)
                                Expanded(
                                  flex: 4,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      const UsernameRow(flex: 2),
                                      const EmailRow(flex: 2),
                                      AdminRow(flex: 2, data: data),
                                    ],
                                  ),
                                ),
                              if (editionMode) AdminRow(flex: 4, data: data),
                              const ExPadding(flex: 1),
                              if (!editionMode)
                                Expanded(
                                  flex: 4,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      const PasswordRow(flex: 2),
                                      const ConfirmPasswordRow(flex: 2),
                                      GeneratePasswordRow(
                                          flex: 2, formKey: _formKey),
                                    ],
                                  ),
                                ),
                              if (editionMode) const ExPadding(flex: 4),
                            ],
                          ),
                        ),
                        const ExPadding(flex: 1),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Text(
                                CustomLocalizations.of(context).selectGroup,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SearchBarRow(flex: 2),
                        GroupSelectionRow(flex: 13, data: data),
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

class AdminRow extends StatelessWidget {
  const AdminRow({
    Key? key,
    required this.flex,
    required this.data,
  }) : super(key: key);

  final int flex;
  final User? data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FormBuilderField(
        name: "admin",
        initialValue: (data == null) ? false : data!.admin,
        builder: (FormFieldState<bool> field) {
          return Container(
            alignment: Alignment.centerRight,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text((data == null)
                        ? CustomLocalizations.of(context).shouldBeAdmin
                        : CustomLocalizations.of(context)
                            .shouldBeAdminName(data!.username!)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconActionButton(
                      icon: Icons.check,
                      iconColor:
                          field.value! ? viewCastColor : Colors.transparent,
                      borderFunc: shadowBorder(32, 32, Colors.white),
                      onTap: () {
                        field.didChange(!field.value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
