import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/services/user_service.dart';

class SearchBarRow extends StatelessWidget {
  final int flex;

  const SearchBarRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InputFieldCustom(
        name: "search",
        color: Colors.white,
        hintLabel: CustomLocalizations.of(context).search,
        textColor: Colors.black,
        borderFunc: shadowBorder(32, 32, Colors.white),
        isVisible: true,
        isSecret: false,
        onChanged: (data) {
          context.read(searchUserProvider).state = data!;
        },
      ),
    );
  }
}
