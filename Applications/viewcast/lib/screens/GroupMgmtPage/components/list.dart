import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/group.dart';
import 'package:viewcast/screens/GroupMgmtPage/components/modal.dart';
import 'package:viewcast/screens/GroupMgmtPage/inspect_displays.dart';
import 'package:viewcast/screens/components/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/row_item.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/styles.dart';

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
          final responseAsyncValue = watch(filteredGroups);
          return responseAsyncValue.map(
            data: (data) {
              return ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, i) {
                  return ListViewItem(index: i, data: data.value[i]);
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

class ColumnNameRow extends StatelessWidget {
  const ColumnNameRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Container(
                decoration: shadowBorder(4, 4, Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final Group data;
  final int index;

  const ListViewItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          RowItem(label: data.name!, flex: 2),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.displayList!.length.toString(),
                    style: TextStyle(
                        color: (data.displayList!.isEmpty)
                            ? Colors.red
                            : Colors.black),
                  ),
                  const SizedBox(width: 16.0),
                  if (data.displayList!.isNotEmpty)
                    Material(
                      child: IconButton(
                        splashColor: Colors.blue.shade100,
                        icon: Icon(Icons.search, color: viewCastColor),
                        onPressed: () => _inspectDisplays(data, context),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Material(
            child: IconButton(
              icon: Icon(Icons.edit, color: viewCastColor),
              onPressed: () => _update(data, context),
            ),
          ),
          Material(
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _delete(data, context),
            ),
          ),
        ],
      ),
    );
  }

  void _inspectDisplays(Group group, BuildContext context) async {
    context.read(selectedGroup.notifier).state = group;

    showDialog(
      context: context,
      builder: (BuildContext context) => const PopUpDisplaysStruct(),
    );
  }

  void _update(Group group, BuildContext context) {
    context.read(editGroup.notifier).state = true;
    context.read(selectedGroup.notifier).state = group;
    context.read(searchDisplayProvider).state = "";
    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }

  void _delete(Group group, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteGroup),
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
        var success = await GroupService.deleteGroup(group.id!);
        if (success) {
          context.read(refreshGroup).state++;
          GroupService.notifyDeleteGroup(group.id!);
          showSuccessSnackBar(
              context, CustomLocalizations.of(context).deleteGroupSnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).deleteGroupSnackError);
        }
      }
    });
  }
}

class GroupRowItem extends StatelessWidget {
  final String label;

  const GroupRowItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(label),
      ),
    );
  }
}
