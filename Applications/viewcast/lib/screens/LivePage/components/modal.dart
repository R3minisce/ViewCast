import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/screens/components/ex_padding.dart';

class PopUpStruct extends StatelessWidget {
  final int modalWidth;
  final int modalHeight;

  const PopUpStruct({
    Key? key,
    required this.modalHeight,
    required this.modalWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        const ExPadding(flex: 1),
        Expanded(
          flex: modalHeight,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const ExPadding(flex: 1),
              PopUpBody(flex: modalWidth),
              const ExPadding(flex: 1),
            ],
          ),
        ),
        const ExPadding(flex: 1),
      ],
    );
  }
}

class PopUpBody extends StatelessWidget {
  final int flex;
  const PopUpBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: shadowBorder(16, 16, Colors.white),
      ),
    );
  }
}
