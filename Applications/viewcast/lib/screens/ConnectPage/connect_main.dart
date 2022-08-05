import 'package:viewcast/components/animated_wave.dart';
import 'package:flutter/material.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/AuthPage/auth_main.dart';
import 'package:viewcast/screens/ConnectPage/components/body.dart';
import 'package:viewcast/styles.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const WaveBackground(),
            SizedBox(
              width: double.infinity,
              child: Flex(
                direction: Axis.vertical,
                children: const [
                  Header(),
                  Body(),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, right: 48.0),
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 300,
          height: 50,
          child: Material(
            child: TextButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(CustomLocalizations.of(context).adminPanel,
                        style: TextStyle(fontSize: 16, color: viewCastColor)),
                    const SizedBox(width: 16.0),
                    Icon(Icons.person, color: viewCastColor, size: size),
                  ]),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) =>
                        const AuthPage(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          CustomLocalizations.of(context).powered,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
