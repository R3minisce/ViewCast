import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/AuthPage/auth_main.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/styles.dart';

class NotAuthPage extends StatelessWidget {
  final String? error;

  const NotAuthPage({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Flex(
        direction: Axis.vertical,
        children: [
          const ExPadding(flex: 1),
          NotAuthBody(error: error),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class NotAuthBody extends StatelessWidget {
  final String? error;
  const NotAuthBody({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Flex(direction: Axis.vertical, children: [
        const Title(flex: 4),
        Expanded(
          flex: 4,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const ExPadding(flex: 5),
              ReturnRow(flex: 4, error: error),
              const ExPadding(flex: 5),
            ],
          ),
        ),
      ]),
    );
  }
}

class Title extends StatelessWidget {
  final int flex;
  const Title({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: SvgPicture.asset(
          'assets/viewcast.svg',
          width: 400,
          height: 200,
        ),
      ),
    );
  }
}

class ReturnRow extends StatelessWidget {
  final int flex;
  final String? error;

  const ReturnRow({
    required this.flex,
    this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: [
          const ExPadding(flex: 2),
          Expanded(
            child: Text(
              error ?? CustomLocalizations.of(context).mustBeAuth,
              style: TextStyle(fontSize: 20, color: Colors.redAccent.shade700),
            ),
          ),
          Expanded(
            child: ActionButton(
              label: CustomLocalizations.of(context).returnToAuth,
              textColor: Colors.white,
              borderFunc: shadowBorder(32, 32, viewCastColor),
              onPressed: () => _goToAuthenticationPage(context),
            ),
          ),
          const ExPadding(flex: 2),
        ],
      ),
    );
  }

  void _goToAuthenticationPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) => const AuthPage(),
      ),
    );
  }
}
