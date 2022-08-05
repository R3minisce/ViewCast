import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 100,
      margin: const EdgeInsets.only(left: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: shadowBorder(4, 4, Colors.red),
      child: InkWell(
        child: Center(
          child: Text(
            CustomLocalizations.of(context).delete,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 100,
      margin: const EdgeInsets.only(left: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        child: Center(
          child: Text(
            CustomLocalizations.of(context).cancel,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(false);
        },
      ),
    );
  }
}
