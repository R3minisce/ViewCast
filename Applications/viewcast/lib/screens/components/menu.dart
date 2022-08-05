import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viewcast/screens/components/navbar.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          Expadding(),
          MenuBody(),
          Expadding(),
        ],
      ),
    );
  }
}

class MenuBody extends StatelessWidget {
  const MenuBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 24,
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          Title(),
          Expadding(),
          NavBar(),
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
        child: SvgPicture.asset(
      'assets/viewcast.svg',
      width: 150,
      height: 75,
      alignment: Alignment.centerLeft,
    ));
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
