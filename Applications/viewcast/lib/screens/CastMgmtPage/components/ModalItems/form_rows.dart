import 'package:flutter/material.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class LabelRow extends StatelessWidget {
  final int flex;
  final Cast? data;
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
          color: Colors.black,
          initialValue: data != null ? data!.name : null,
          hintLabel: CustomLocalizations.of(context).castLabel,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.minLength(context, 3),
            FormBuilderValidators.maxLength(context, 50),
          ]),
        ),
      ),
    );
  }
}
