import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/event_inspection.dart';
import 'package:viewcast/screens/CastMgmtPage/components/ModalItems/searchbar.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/event_service.dart';

class PopUpEventsStruct extends StatelessWidget {
  const PopUpEventsStruct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Flex(
        direction: Axis.vertical,
        children: [
          const ExPadding(flex: 1),
          Expanded(
            flex: 28,
            child: Container(
                color: Colors.transparent,
                child: Flex(
                  direction: Axis.horizontal,
                  children: const [
                    ExPadding(flex: 3),
                    PopUpEventsBody(flex: 10),
                    ExPadding(flex: 3),
                  ],
                )),
          ),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class PopUpEventsBody extends StatelessWidget {
  final int flex;
  const PopUpEventsBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: shadowBorder(16, 16, Colors.white.withOpacity(0.9)),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            const ExPadding(flex: 1),
            Expanded(
              flex: 30,
              child: Consumer(builder: (context, watch, child) {
                var data = watch(selectedCast.notifier).state;
                final filter = watch(searchEventProvider).state;
                List<Event> filteredEvents = [];
                if (data != null) {
                  filteredEvents = data.events!
                      .where((event) => event.name!
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .toList();
                }

                if (data != null) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      const ExPadding(flex: 1),
                      TitleRow(
                        flex: 2,
                        label: CustomLocalizations.of(context)
                            .castEvents(data.name!),
                        searchProviders: [
                          //searchGroupProvider,
                          searchEventProvider
                        ],
                        editProvider: editCast,
                        selectedProvider: selectedCast,
                      ),
                      const ExPadding(flex: 1),
                      SearchBarRow(
                          flex: 2,
                          provider: searchEventProvider,
                          name: "search"),
                      const ExPadding(flex: 1),
                      EventInspectionRow(
                          flex: 18, data: data, events: filteredEvents),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            ),
            const ExPadding(flex: 1),
          ],
        ),
      ),
    );
  }
}
