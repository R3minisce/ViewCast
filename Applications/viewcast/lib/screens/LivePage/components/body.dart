import 'package:flutter/material.dart';
import 'package:viewcast/screens/LivePage/components/grid.dart';
import 'package:viewcast/screens/LivePage/components/pre_grid.dart';
import 'package:viewcast/screens/components/ex_padding.dart';

class Body extends StatelessWidget {
  final int flex;
  const Body({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: const [
          ExPadding(flex: 2),
          PreGridRow(flex: 2),
          ExPadding(flex: 1),
          GridRow(flex: 24),
          ExPadding(flex: 2),
        ],
      ),
    );
  }
}
