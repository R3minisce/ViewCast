import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';

import 'package:viewcast/screens/DisplayMgmtPage/components/modal.dart';

import 'package:viewcast/screens/components/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/row_item.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/display_service.dart';

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
          final responseAsyncValue = watch(filteredDisplays);
          final refreshDisplayProvider = watch(refreshDisplay);
          return responseAsyncValue.map(
            data: (data) {
              return ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, i) {
                  return ListViewItem(
                    index: i,
                    data: data.value[i],
                    refreshDisplayProvider: refreshDisplayProvider,
                  );
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
  final StateController<int> refreshDisplayProvider;
  final Display data;
  final int index;

  const ListViewItem({
    Key? key,
    required this.refreshDisplayProvider,
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
          RowItem(label: data.name!, flex: 2),
          RowItem(
              label: "${date.year}-$month-${date.day} ${date.hour}:$minute",
              flex: 2),
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

  void _update(Display display, BuildContext context) {
    context.read(editDisplay.notifier).state = true;
    context.read(selectedDisplay.notifier).state = display;

    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }

  void _delete(Display display, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteDisplay),
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
        var success = await DisplayService.deleteDisplay(display.id!);
        if (success) {
          refreshDisplayProvider.state++;
          DisplayService.notifyDeleteDisplay(display.id!);
          showSuccessSnackBar(context,
              CustomLocalizations.of(context).deleteDisplaySnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).deleteDisplaySnackError);
        }
      }
    });
  }
}
