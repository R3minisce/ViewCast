import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/styles.dart';

class ValidationRow extends StatelessWidget {
  final int flex;
  final GlobalKey<FormBuilderState> formKey;

  const ValidationRow({
    Key? key,
    required this.flex,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Consumer(
          builder: (context, watch, child) {
            var editionMode = watch(editUser.notifier).state;
            return ActionButton(
              label: CustomLocalizations.of(context).validate,
              textColor: Colors.white,
              borderFunc: shadowBorder(32, 32, viewCastColor),
              onPressed: () async => (!editionMode)
                  ? _addUser(
                      context,
                      watch(refreshUser),
                    )
                  : _editUser(
                      context,
                      watch(refreshUser),
                    ),
            );
          },
        ),
      ),
    );
  }

  void _addUser(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var username = formKey.currentState!.value['username'];
      var email = formKey.currentState!.value['email'];
      var password = formKey.currentState!.value['password'];
      List<int> groups = formKey.currentState!.value['groups'];
      var admin = formKey.currentState!.value['admin'];

      User? res = await UserService.addUser(
        {
          'username': username,
          'email': email,
          'password': password,
          'admin': admin,
          'groups_ids': groups,
        },
      );

      if (res != null) {
        refreshProvider.state++;
        formKey.currentState!.reset();
        context.read(searchGroupProvider).state = "";
        Navigator.of(context).pop();

        showSuccessSnackBar(
            context, CustomLocalizations.of(context).addUserSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).addUserSnackError);
      }
    }
  }

  void _editUser(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      List<int> groups = formKey.currentState!.value['groups'];
      var admin = formKey.currentState!.value['admin'];
      var editedUser = context.read(selectedUser.notifier).state;

      var res = await UserService.updateUser({
        'admin': admin,
        'groups_ids': groups,
      }, editedUser!.uuid!);

      if (res) {
        refreshProvider.state++;
        formKey.currentState!.reset();
        context.read(searchGroupProvider).state = "";
        context.read(selectedUser.notifier).state = null;
        context.read(editUser.notifier).state = false;
        Navigator.of(context).pop();

        showSuccessSnackBar(
            context, CustomLocalizations.of(context).editUserSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).editUserSnackError);
      }
    }
  }
}
