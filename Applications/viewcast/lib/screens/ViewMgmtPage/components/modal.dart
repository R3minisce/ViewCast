import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/view.dart';
import 'package:viewcast/screens/ViewMgmtPage/components/ModalItems/form_rows.dart';
import 'package:viewcast/screens/ViewMgmtPage/components/ModalItems/picture_grid_row.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';
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
                var editionMode = watch(editView).state;
                var data = watch(selectedView).state;
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
                            label: (!editionMode)
                                ? CustomLocalizations.of(context).createView
                                : CustomLocalizations.of(context)
                                    .editView(data!.name!),
                            searchProviders: [searchFileProvider],
                            editProvider: editView,
                            selectedProvider: selectedView),
                        const ExPadding(flex: 1),
                        LabelRow(flex: 2, data: data),
                        const ExPadding(flex: 1),
                        const SearchRow(flex: 2),
                        const ExPadding(flex: 1),
                        GridStruct(flex: 18, data: data),
                        ValidationRow(flex: 2, formKey: _formKey),
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

class ValidationRow extends StatelessWidget {
  final int flex;
  const ValidationRow({
    Key? key,
    required this.flex,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: ActionButton(
          label: CustomLocalizations.of(context).validate,
          textColor: Colors.white,
          borderFunc: shadowBorder(32, 32, viewCastColor),
          onPressed: () async => !context.read(editView.notifier).state
              ? _addView(
                  context,
                  context.read(refreshView),
                )
              : _editView(
                  context,
                  context.read(refreshView),
                ),
        ),
      ),
    );
  }

  void _addView(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      List<int> files = formKey.currentState!.value['files'];

      View? res = await ViewService.addView(
        {
          'name': label,
          'files_ids': files,
        },
      );

      if (res != null) {
        refreshProvider.state++;
        formKey.currentState!.reset();
        context.read(searchFileProvider).state = "";
        Navigator.of(context).pop();

        showSuccessSnackBar(
            context, CustomLocalizations.of(context).addViewSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).addViewSnackError);
      }
    }
  }

  void _editView(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      List<int> files = formKey.currentState!.value['files'];

      var editedView = context.read(selectedView.notifier).state;

      var res = await ViewService.updateView({
        'name': label,
        'files_ids': files,
      }, editedView!.id!);

      if (res) {
        refreshProvider.state++;
        ViewService.notifyUpdateView(editedView.id!);
        formKey.currentState!.reset();
        context.read(searchFileProvider).state = "";
        Navigator.of(context).pop();

        showSuccessSnackBar(
            context, CustomLocalizations.of(context).editViewSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).editViewSnackError);
      }
    }
  }
}
