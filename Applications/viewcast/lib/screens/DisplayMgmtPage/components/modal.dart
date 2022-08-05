import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

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
          const ExPadding(flex: 5),
          Expanded(
            flex: 5,
            child: Container(
                color: Colors.transparent,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const ExPadding(flex: 2),
                    ModalBody(flex: 2),
                    const ExPadding(flex: 2),
                  ],
                )),
          ),
          const ExPadding(flex: 5),
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
                var data = watch(selectedDisplay.notifier).state;
                var editionMode = watch(editDisplay.notifier).state;
                return Expanded(
                  flex: 30,
                  child: FormBuilder(
                    key: _formKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        const ExPadding(flex: 1),
                        TitleRow(
                          flex: 2,
                          label: (!editionMode)
                              ? CustomLocalizations.of(context).createDisplay
                              : CustomLocalizations.of(context)
                                  .editDisplay(data!.name!),
                          searchProviders: const [],
                          editProvider: editDisplay,
                          selectedProvider: selectedDisplay,
                        ),
                        const ExPadding(flex: 1),
                        LabelRow(flex: 2, data: data),
                        const ExPadding(flex: 1),
                        ValidationRow(
                          flex: 2,
                          formKey: _formKey,
                        ),
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
  const ValidationRow({Key? key, required this.flex, required this.formKey})
      : super(key: key);

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
            onPressed: () => (!context.read(editDisplay.notifier).state)
                ? _addDisplay(context, context.read(refreshDisplay))
                : _editDisplay(context, context.read(refreshDisplay))),
      ),
    );
  }

  _addDisplay(BuildContext context, refreshDisplayProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];

      var res = await DisplayService.addDisplay({
        "name": label,
      });
      if (res != null) {
        refreshDisplayProvider.state++;
        formKey.currentState!.reset();

        Navigator.of(context).pop();
        showSuccessSnackBar(
          context,
          CustomLocalizations.of(context).addDisplaySnackSucess,
        );
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).addDisplaySnackError);
      }
    }
  }

  _editDisplay(BuildContext context, refreshDisplayProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];

      var editedDisplay = context.read(selectedDisplay.notifier).state;

      var res = await DisplayService.updateDisplay({
        "name": label,
      }, editedDisplay!.id!);
      if (res) {
        refreshDisplayProvider.state++;
        formKey.currentState!.reset();
        context.read(selectedDisplay.notifier).state = null;
        context.read(editDisplay.notifier).state = false;

        Navigator.of(context).pop();
        showSuccessSnackBar(
          context,
          CustomLocalizations.of(context).editDisplaySnackSucess,
        );
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).editDisplaySnackError);
      }
    }
  }
}

class LabelRow extends StatelessWidget {
  final int flex;
  final Display? data;
  const LabelRow({
    Key? key,
    required this.flex,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: InputFieldCustom(
          name: "label",
          initialValue: data != null ? data!.name : null,
          color: Colors.black,
          hintLabel: CustomLocalizations.of(context).displayName,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 5),
            FormBuilderValidators.maxLength(context, 20),
          ]),
        ),
      ),
    );
  }
}
