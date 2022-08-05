import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/animated_wave.dart';
import 'package:flutter/material.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/screens/AuthPage/components/body.dart';
import 'package:viewcast/screens/ConnectPage/connect_main.dart';
import 'package:viewcast/styles.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setKDays(context);
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
                  FooterMain(),
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
        padding: const EdgeInsets.only(top: 16.0, right: 48.0, left: 48.0),
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: Consumer(
                builder: (context, watch, child) {
                  var currentLanguage = watch(localeProvider).state;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          "EN",
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentLanguage == "en")
                                  ? Colors.red
                                  : viewCastColor),
                        ),
                        onPressed: () => _changeLanguage('en', context),
                      ),
                      const SizedBox(width: 16.0),
                      TextButton(
                        child: Text(
                          "FR",
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentLanguage == "fr")
                                  ? Colors.red
                                  : viewCastColor),
                        ),
                        onPressed: () => _changeLanguage('fr', context),
                      ),
                      const SizedBox(width: 16.0),
                      TextButton(
                        child: Text(
                          "NL",
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentLanguage == "nl")
                                  ? Colors.red
                                  : viewCastColor),
                        ),
                        onPressed: () => _changeLanguage('nl', context),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: Material(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        CustomLocalizations.of(context).connectDisplay,
                        style: TextStyle(fontSize: 16, color: viewCastColor),
                      ),
                      const SizedBox(width: 16.0),
                      Icon(Icons.monitor, color: viewCastColor, size: size),
                    ],
                  ),
                  onPressed: () => _navigateToConnectPage(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String language, BuildContext context) {
    context.read(localeProvider.notifier).state = language;
  }

  void _navigateToConnectPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) => const ConnectPage(),
      ),
    );
  }
}

class FooterMain extends StatelessWidget {
  const FooterMain({
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
