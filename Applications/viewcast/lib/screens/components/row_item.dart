import 'package:flutter/material.dart';
import 'package:viewcast/styles.dart';

class RowItem extends StatelessWidget {
  final String label;
  final int flex;

  const RowItem({
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class DayItem extends StatelessWidget {
  final List<String> days;
  final int flex;

  const DayItem({
    Key? key,
    required this.days,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: _getDays(context),
      ),
    );
  }

  List<Widget> _getDays(BuildContext context) {
    List<Widget> daysList = [];
    for (String day in kDays) {
      daysList.add(
        Expanded(
          child: Text(
            day[0],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    days.contains(day) ? viewCastColor : Colors.grey.shade300),
          ),
        ),
      );
    }

    return daysList;
  }
}

class ListItem extends StatelessWidget {
  final List<dynamic>? data;
  final int flex;

  const ListItem({
    Key? key,
    required this.data,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: _getData(),
      ),
    );
  }

  List<Widget> _getData() {
    List<Widget> dataList = [];
    for (dynamic element in data!) {
      dataList.add(
        Expanded(
          child: Text(element.id,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: viewCastColor,
              )),
        ),
      );
    }

    return dataList;
  }
}
