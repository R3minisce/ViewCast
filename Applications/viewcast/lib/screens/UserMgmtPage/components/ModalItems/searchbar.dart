import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/services/group_service.dart';

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
      child: Container(
        padding:
            const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0, left: 4.0),
        child: InputFieldCustom(
          name: "search",
          color: Colors.white,
          hintLabel: CustomLocalizations.of(context).search,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: true,
          isSecret: false,
          onChanged: (data) {
            context.read(searchGroupProvider).state = data!;
          },
        ),
      ),
    );
  }
}
