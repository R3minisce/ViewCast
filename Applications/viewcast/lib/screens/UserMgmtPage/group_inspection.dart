import 'package:flutter/material.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/group.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/styles.dart';

class GroupInspectionRow extends StatelessWidget {
  final int flex;
  final User? data;
  final List<Group> groups;
  GroupInspectionRow({
    Key? key,
    required this.flex,
    required this.data,
    required this.groups,
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
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return GridViewItem(
                      index: index,
                      data: groups[index],
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
  final Group data;

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
            const SizedBox(height: 16.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.displayList != null
                        ? data.displaysCount.toString()
                        : CustomLocalizations.of(context).noDisplay,
                    style: TextStyle(
                        color: viewCastColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8.0),
                  Icon(Icons.monitor, color: viewCastColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
