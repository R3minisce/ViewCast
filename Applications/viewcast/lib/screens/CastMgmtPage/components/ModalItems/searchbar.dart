import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';

class SearchBarRow extends StatelessWidget {
  final int flex;
  final String name;
  final StateProvider<String> provider;

  const SearchBarRow({
    Key? key,
    required this.flex,
    required this.provider,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding:
            const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0, left: 4.0),
        child: InputFieldCustom(
          name: name,
          color: Colors.white,
          hintLabel: CustomLocalizations.of(context).search,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: true,
          isSecret: false,
          onChanged: (data) {
            context.read(provider).state = data!;
          },
        ),
      ),
    );
  }
}
