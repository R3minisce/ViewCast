import 'package:flutter/material.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/models/group.dart';

import 'package:viewcast/styles.dart';

class DisplayInspectionRow extends StatelessWidget {
  final int flex;
  final Group? data;
  final List<Display> displays;
  DisplayInspectionRow({
    Key? key,
    required this.flex,
    required this.data,
    required this.displays,
  }) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 15,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: GridView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: displays.length,
                  itemBuilder: (context, index) {
                    return GridViewItem(
                      index: index,
                      data: displays[index],
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final Display data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: shadowBorder(16, 16, Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              data.name ?? CustomLocalizations.of(context).noName,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: viewCastColor, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
