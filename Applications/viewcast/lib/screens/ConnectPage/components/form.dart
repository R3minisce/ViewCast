import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/screens/CastingPage/casting_main.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class ConnectForm extends StatelessWidget {
  ConnectForm({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Flex(
          direction: Axis.vertical,
          children: [
            const ExPadding(flex: 4),
            const UsernameRow(flex: 2),
            const ExPadding(flex: 1),
            ConnectRow(formKey: _formKey, flex: 2),
            const ExPadding(flex: 5),
          ],
        ),
      ),
    );
  }
}

class UsernameRow extends StatelessWidget {
  final int flex;
  const UsernameRow({
    required this.flex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InputFieldCustom(
        name: "name",
        validator: FormBuilderValidators.required(context),
        textColor: Colors.black,
        color: Colors.white,
        hintLabel: CustomLocalizations.of(context).displayName,
        borderFunc: shadowBorder(32, 32, Colors.white),
        isVisible: false,
        isSecret: false,
      ),
    );
  }
}

class ConnectRow extends StatelessWidget {
  final int flex;

  const ConnectRow({
    required this.flex,
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: ActionButton(
              label: CustomLocalizations.of(context).connect,
              textColor: Colors.white,
              borderFunc: shadowBorder(32, 32, viewCastColor),
              onPressed: () => _connect(context),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _connect(BuildContext context) async {
    if (formKey.currentState!.saveAndValidate()) {
      var name = formKey.currentState!.value['name'];

      Display? res = await DisplayService.getDisplayByName(name);
      if (res != null) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) =>
                CastingPage(display: res),
          ),
        );
      } else {
        _showSnackBar(context);
      }
    }
  }

  void _showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(
        CustomLocalizations.of(context).connectSnackError,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
