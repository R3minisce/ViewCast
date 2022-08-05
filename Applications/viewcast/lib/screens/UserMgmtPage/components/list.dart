import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/UserMgmtPage/components/modal.dart';
import 'package:viewcast/screens/UserMgmtPage/inspect_groups.dart';
import 'package:viewcast/screens/components/buttons.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/row_item.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/utils.dart';

class ListRow extends StatelessWidget {
  final int flex;

  const ListRow({
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
          ListBody(flex: 24),
          ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class ListBody extends StatelessWidget {
  final int flex;

  const ListBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Consumer(
        builder: (context, watch, child) {
          final responseAsyncValue = watch(filteredUsers);
          final refreshUserProvider = watch(refreshUser);
          return responseAsyncValue.map(
            data: (data) {
              return ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, i) {
                  return ListViewItem(
                      index: i,
                      data: data.value[i],
                      refreshUserProvider: refreshUserProvider);
                },
              );
            },
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (_) =>
                Center(child: Text(CustomLocalizations.of(context).error)),
          );
        },
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final StateController<int> refreshUserProvider;
  final User data;
  final int index;

  const ListViewItem({
    Key? key,
    required this.refreshUserProvider,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = data.creationTime!.toLocal();
    String minute = Utils.formatMinute(date);
    String month = Utils.formatMonth(date);
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: shadowBorder(8, 8, Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          RowItem(label: "${index + 1}", flex: 1),
          RowItem(label: data.username!, flex: 2),
          RowItem(
              label: "${date.year}-$month-${date.day} ${date.hour}:$minute",
              flex: 2),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.groups!.length.toString(),
                    style: TextStyle(
                        color:
                            (data.groups!.isEmpty) ? Colors.red : Colors.black),
                  ),
                  const SizedBox(width: 16.0),
                  if (data.groups!.isNotEmpty)
                    Material(
                      child: IconButton(
                        splashColor: Colors.blue.shade100,
                        icon: Icon(Icons.search, color: viewCastColor),
                        onPressed: () => _inspectGroups(data, context),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: (!data.admin!)
                  ? Icon(Icons.person, color: viewCastColor)
                  : Icon(Icons.grade, color: Colors.yellow.shade800),
            ),
          ),
          Material(
            child: IconButton(
              splashColor: Colors.blue.shade100,
              icon: Icon(Icons.edit, color: viewCastColor),
              onPressed: () => _update(data, context),
            ),
          ),
          Material(
            child: IconButton(
              splashColor: Colors.blue.shade100,
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _delete(data, context),
            ),
          ),
        ],
      ),
    );
  }

  void _inspectGroups(User user, BuildContext context) async {
    context.read(selectedUser.notifier).state = user;

    showDialog(
      context: context,
      builder: (BuildContext context) => const PopUpGroupsStruct(),
    );
  }

  void _update(User user, BuildContext context) {
    context.read(editUser.notifier).state = true;
    context.read(selectedUser.notifier).state = user;
    context.read(searchGroupProvider).state = "";
    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }

  void _delete(User user, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteUser),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    Future confirmation = showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    confirmation.then((value) async {
      if (value != null && value) {
        var success = await UserService.deleteUser(user.uuid!);
        if (success) {
          refreshUserProvider.state++;

          showSuccessSnackBar(
              context, CustomLocalizations.of(context).deleteUserSnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).deleteUserSnackError);
        }
      }
    });
  }
}
