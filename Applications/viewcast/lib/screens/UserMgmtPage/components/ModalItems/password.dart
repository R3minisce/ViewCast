import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:random_string/random_string.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/icon_button.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class PasswordRow extends StatelessWidget {
  final int flex;
  const PasswordRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Consumer(
                builder: (context, watch, child) {
                  return InputFieldCustom(
                    name: "password",
                    color: Colors.black,
                    hintLabel: CustomLocalizations.of(context).password,
                    textColor: Colors.black,
                    borderFunc: shadowBorder(32, 32, Colors.white),
                    isVisible: false,
                    isSecret: watch(visibilityProvider).state,
                    onChanged: (data) {
                      watch(passwordProvider.notifier).state = data!;
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.match(context,
                          "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{12,}\$"),
                    ]),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context, watch, child) {
                return Container(
                  padding: const EdgeInsets.all(4.0),
                  child: IconActionButton(
                    icon: watch(visibilityProvider).state
                        ? Icons.visibility_off
                        : Icons.visibility,
                    iconColor: viewCastColor,
                    borderFunc: shadowBorder(32, 32, Colors.white),
                    onTap: () => _changeVisibility(watch(visibilityProvider)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeVisibility(var visibility) {
    visibility.state = !visibility.state;
  }
}

class ConfirmPasswordRow extends StatelessWidget {
  final int flex;
  const ConfirmPasswordRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Consumer(
        builder: (context, watch, child) {
          return Container(
            padding: const EdgeInsets.all(4.0),
            child: InputFieldCustom(
                name: "confirmPassword",
                color: Colors.black,
                hintLabel: CustomLocalizations.of(context).confirmPassword,
                textColor: Colors.black,
                borderFunc: shadowBorder(32, 32, Colors.white),
                isVisible: false,
                isSecret: watch(visibilityProvider).state,
                validator: (val) => _confirmPasswordValidator(
                    context, watch(passwordProvider).state, val)),
          );
        },
      ),
    );
  }

  String? _confirmPasswordValidator(BuildContext context, String passwordValue,
      String? confirmPasswordValue) {
    if (confirmPasswordValue != passwordValue) {
      return CustomLocalizations.of(context).passwordNotMatch;
    }
  }
}

class GeneratePasswordRow extends StatelessWidget {
  final int flex;
  final GlobalKey<FormBuilderState> formKey;
  const GeneratePasswordRow({
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
        child: ActionButton(
          label: CustomLocalizations.of(context).generatePass,
          textColor: Colors.white,
          borderFunc: shadowBorder(32, 32, viewCastColor),
          onPressed: () => _generateAndSavePassword(),
        ),
      ),
    );
  }

  void _generateAndSavePassword() {
    var random = Random.secure();
    var regex = RegExp(
        "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{12,}\$");
    int length;
    String password;
    do {
      length = randomBetween(12, 18, provider: CoreRandomProvider.from(random));
      password = randomString(length);
    } while (!regex.hasMatch(password));
    formKey.currentState!.patchValue({"password": password});
    formKey.currentState!.patchValue({"confirmPassword": password});
  }
}
