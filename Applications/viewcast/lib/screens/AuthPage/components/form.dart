import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
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
            const ExPadding(flex: 1),
            const UsernameRow(flex: 2),
            const ExPadding(flex: 1),
            const PasswordRow(flex: 2),
            const ExPadding(flex: 1),
            SignInRow(formKey: _formKey, flex: 2),
            const ForgottenRow(flex: 2),
            const ExPadding(flex: 3),
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
        name: "username",
        validator: FormBuilderValidators.required(context),
        textColor: Colors.black,
        color: Colors.white,
        hintLabel: CustomLocalizations.of(context).username,
        borderFunc: shadowBorder(32, 32, Colors.white),
        isVisible: false,
        isSecret: false,
      ),
    );
  }
}

class PasswordRow extends StatelessWidget {
  final int flex;
  const PasswordRow({
    required this.flex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InputFieldCustom(
        name: "password",
        validator: FormBuilderValidators.required(context),
        textColor: Colors.black,
        color: Colors.white,
        hintLabel: CustomLocalizations.of(context).password,
        borderFunc: shadowBorder(32, 32, Colors.white),
        isVisible: false,
        isSecret: true,
      ),
    );
  }
}

class SignInRow extends StatelessWidget {
  final int flex;

  const SignInRow({
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
              label: CustomLocalizations.of(context).signIn,
              textColor: Colors.white,
              borderFunc: shadowBorder(32, 32, viewCastColor),
              onPressed: () => _signIn(context),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _signIn(BuildContext context) async {
    if (formKey.currentState!.saveAndValidate()) {
      var username = formKey.currentState!.value['username'];
      var password = formKey.currentState!.value['password'];

      String? res = await UserService.getToken(username, password);
      if (res != null) {
        User? user = await UserService.login(res);
        if (user != null) {
          context.read(currentUserProvider.notifier).state = user;
          Navigator.of(context).pushNamed('/live');
        } else {
          _showSnackBar(context);
        }
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
        CustomLocalizations.of(context).invalidAuth,
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

class ForgottenRow extends StatelessWidget {
  const ForgottenRow({
    required this.flex,
    Key? key,
  }) : super(key: key);
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                CustomLocalizations.of(context).forgottenPassword,
                style: TextStyle(
                  fontSize: 18,
                  color: viewCastColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
