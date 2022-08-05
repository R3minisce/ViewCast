import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viewcast/screens/AuthPage/components/form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Flex(
        direction: Axis.vertical,
        children: const [
          Title(),
          FormStruct(),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Center(
        child: SvgPicture.asset(
          'assets/viewcast.svg',
          width: 400,
          height: 200,
        ),
      ),
    );
  }
}

class FormStruct extends StatelessWidget {
  const FormStruct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(),
          ),
          SignInForm(),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
