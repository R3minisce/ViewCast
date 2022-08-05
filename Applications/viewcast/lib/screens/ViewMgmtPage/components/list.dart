import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/view.dart';
import 'package:viewcast/screens/ViewMgmtPage/components/modal.dart';
import 'package:viewcast/screens/ViewMgmtPage/inspect_files.dart';
import 'package:viewcast/screens/components/buttons.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/row_item.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/screens/components/snackbars.dart';

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
          final responseAsyncValue = watch(filteredViews);
          final refreshViewProvider = watch(refreshView);

          return responseAsyncValue.map(
            data: (data) {
              return ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, i) {
                  return ListViewItem(
                      index: i,
                      data: data.value[i],
                      refreshViewProvider: refreshViewProvider);
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
  final StateController<int> refreshViewProvider;
  final View data;
  final int index;

  const ListViewItem({
    Key? key,
    required this.refreshViewProvider,
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
                    data.filesCount.toString(),
                    style: TextStyle(
                        color:
                            (data.filesCount == 0) ? Colors.red : Colors.black),
                  ),
                  const SizedBox(width: 16.0),
                  if (data.filesCount != 0)
                    Material(
                      child: IconButton(
                        splashColor: Colors.blue.shade100,
                        icon: Icon(Icons.search, color: viewCastColor),
                        onPressed: () => _inspectFiles(data, context),
                      ),
                    ),
                ],
              ),
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

  void _inspectFiles(View view, BuildContext context) async {
    var viewFull =
        await context.read(getViewWithFilesProvider.call(view.id!).future);
    context.read(selectedView.notifier).state = viewFull;

    showDialog(
      context: context,
      builder: (BuildContext context) => const PopUpFilesStruct(),
    );
  }

  void _update(View view, BuildContext context) {
    context.read(editView.notifier).state = true;
    context.read(selectedView.notifier).state = view;
    context.read(searchFileProvider).state = "";
    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }

  void _delete(View view, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteView),
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
        var success = await ViewService.deleteView(view.id!);
        if (success) {
          refreshViewProvider.state++;
          ViewService.notifyDeleteView(view.id!);
          showSuccessSnackBar(
              context, CustomLocalizations.of(context).deleteViewSnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).deleteViewSnackError);
        }
      }
    });
  }
}
