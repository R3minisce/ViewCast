import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/cast_service.dart';
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
            var editionMode = watch(editCast.notifier).state;
            return ActionButton(
              label: CustomLocalizations.of(context).validate,
              textColor: Colors.white,
              borderFunc: shadowBorder(32, 32, viewCastColor),
              onPressed: () async => (!editionMode)
                  ? _addCast(
                      context,
                      watch(refreshCast),
                    )
                  : _editCast(
                      context,
                      watch(refreshCast),
                    ),
            );
          },
        ),
      ),
    );
  }

  void _addCast(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      List<int> groups = formKey.currentState!.value['groups'];
      List<int> events = formKey.currentState!.value['events'];

      Cast? res = await CastService.addCast(
        {
          'name': label,
          'groups_ids': groups,
          'events_ids': events,
        },
      );

      if (res != null) {
        refreshProvider.state++;
        formKey.currentState!.reset();
        context.read(conflictingEventsIds.notifier).state = [];
        CastService.notifyUpdateCast(res.id!);
        Navigator.of(context).pop();
        showSuccessSnackBar(
            context, CustomLocalizations.of(context).addCastSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).addCastSnackError);
      }
    }
  }

  void _editCast(BuildContext context, var refreshProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      List<int> groups = formKey.currentState!.value['groups'];
      List<int> events = formKey.currentState!.value['events'];

      var editedCast = context.read(selectedCast.notifier).state;

      var res = await CastService.updateCast({
        'name': label,
        'groups_ids': groups,
        'events_ids': events,
      }, editedCast!.id!);

      if (res) {
        refreshProvider.state++;
        CastService.notifyUpdateCast(editedCast.id!);
        formKey.currentState!.reset();
        context.read(selectedCast.notifier).state = null;
        context.read(editCast.notifier).state = false;
        Navigator.of(context).pop();
        showSuccessSnackBar(
            context, CustomLocalizations.of(context).editCastSnackSuccess);
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).editCastSnackError);
      }
    }
  }
}
