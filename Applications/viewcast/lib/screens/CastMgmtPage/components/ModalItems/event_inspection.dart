import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/styles.dart';

class EventInspectionRow extends StatelessWidget {
  final int flex;
  final Cast? data;
  final List<Event> events;
  EventInspectionRow({
    Key? key,
    required this.flex,
    required this.data,
    required this.events,
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
              child: (events.isNotEmpty)
                  ? GridView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 16,
                      ),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return GridViewItem(
                          index: index,
                          data: events[index],
                        );
                      },
                    )
                  : Container(),
            ),
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
  final Event data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: shadowBorder(16, 16, Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ExPadding(flex: 1),
          Expanded(
            flex: 2,
            child: Text(
              data.name ?? CustomLocalizations.of(context).noName,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          if (data.specificDate != null)
            Expanded(
              flex: 2,
              child: Text(
                "${data.specificDate}",
                textAlign: TextAlign.left,
              ),
            ),
          if (data.specificDate == null)
            Expanded(
              flex: 2,
              child: Flex(
                direction: Axis.horizontal,
                children: _getDays(context),
              ),
            ),
          Expanded(
            flex: 2,
            child: Text(
              "${data.startHour} - ${data.endHour}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
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
              color: data.days!.contains(day)
                  ? viewCastColor
                  : Colors.grey.shade300,
            ),
          ),
        ),
      );
    }

    return daysList;
  }
}
