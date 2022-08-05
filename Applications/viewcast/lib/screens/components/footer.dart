import 'package:flutter/material.dart';
import 'package:viewcast/localization/l10n.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Expadding(),
          Expanded(
            flex: 24,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                CustomLocalizations.of(context).powered,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Expadding(),
        ],
      ),
    );
  }
}

class Expadding extends StatelessWidget {
  const Expadding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(),
    );
  }
}
