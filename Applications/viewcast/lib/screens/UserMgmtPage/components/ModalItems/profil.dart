import 'package:flutter/material.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class UsernameRow extends StatelessWidget {
  final int flex;
  const UsernameRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: InputFieldCustom(
          name: "username",
          color: Colors.black,
          hintLabel: CustomLocalizations.of(context).username,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.minLength(context, 5),
            FormBuilderValidators.maxLength(context, 20),
          ]),
        ),
      ),
    );
  }
}

class EmailRow extends StatelessWidget {
  final int flex;
  const EmailRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: InputFieldCustom(
          name: "email",
          color: Colors.black,
          hintLabel: CustomLocalizations.of(context).email,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.email(context),
          ]),
        ),
      ),
    );
  }
}
