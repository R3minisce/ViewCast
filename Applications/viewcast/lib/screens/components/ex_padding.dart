import 'package:flutter/material.dart';

class ExPadding extends StatelessWidget {
  final int flex;

  const ExPadding({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(color: Colors.transparent),
    );
  }
}
