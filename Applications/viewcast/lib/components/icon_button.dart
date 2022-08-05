import 'package:flutter/material.dart';

class IconActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Decoration borderFunc;
  final VoidCallback onTap;

  const IconActionButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.borderFunc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: borderFunc,
          width: double.infinity,
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              splashColor:
                  const Color.fromARGB(100, 75, 150, 230).withOpacity(0.6),
              onTap: onTap,
              child: Align(
                child: Icon(icon, color: iconColor),
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
