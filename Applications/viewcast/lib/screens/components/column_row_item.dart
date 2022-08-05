import 'package:flutter/material.dart';

class ColumnRowItem extends StatelessWidget {
  final String label;
  final int flex;

  const ColumnRowItem({
    Key? key,
    required this.label,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
