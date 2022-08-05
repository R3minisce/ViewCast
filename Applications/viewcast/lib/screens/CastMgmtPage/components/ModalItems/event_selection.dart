import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/event_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class EventSelectionRow extends StatelessWidget {
  final int flex;
  final Cast? data;
  EventSelectionRow({
    Key? key,
    required this.flex,
    required this.data,
  }) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final responseAsyncValue = watch(filteredAvailableEvents);
        final conflictingIds = watch(conflictingEventsIds).state;

        return responseAsyncValue.map(
          data: (events) {
            return Expanded(
              flex: flex,
              child: FormBuilderField(
                name: "events",
                initialValue:
                    (data == null) ? List<int>.empty() : data!.eventsIds,
                validator: FormBuilderValidators.required(context),
                autovalidateMode: AutovalidateMode.disabled,
                builder: (FormFieldState<List<int>> field) {
                  List<int> selectedIds = field.value!;

                  _handleRemove(selectedIds, context, events.value);
                  _sortEvents(events.value, conflictingIds, selectedIds);

                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 15,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 9,
                            ),
                            itemCount: events.value.length,
                            itemBuilder: (context, index) {
                              return GridViewItem(
                                index: index,
                                data: events.value[index],
                                field: field,
                                isConflicting: _isConflicting(
                                  conflictingIds,
                                  events.value[index],
                                ),
                                events: events.value,
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            field.errorText ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          loading: (_) => Expanded(
            flex: flex,
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (_) => Expanded(
            flex: flex,
            child: Center(
                child: Text(CustomLocalizations.of(context).eventListEmpty)),
          ),
        );
      },
    );
  }

  _sortEvents(
      List<Event> events, List<int> conflictingIds, List<int> selectedIds) {
    events.sort((a, b) =>
        conflictingIds.indexOf(a.id!) - conflictingIds.indexOf(b.id!));
    events.sort(
        (a, b) => selectedIds.indexOf(b.id!) - selectedIds.indexOf(a.id!));
  }

  _isConflicting(List<int> conflictingIds, Event event) {
    return !(conflictingIds.contains(event.id));
  }
}

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    Key? key,
    required this.index,
    required this.data,
    required this.field,
    required this.isConflicting,
    required this.events,
  }) : super(key: key);

  final int index;
  final Event data;
  final List<Event> events;
  final bool isConflicting;
  final FormFieldState<List<int>> field;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: isConflicting
            ? shadowBorder(16, 16,
                field.value!.contains(data.id) ? viewCastColor : Colors.white)
            : shadowBorder(16, 16, Colors.grey.withOpacity(0.8)),
        child: Stack(
          children: [
            if (field.value!.contains(data.id))
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
            Flex(
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isConflicting
                              ? field.value!.contains(data.id)
                                  ? Colors.white
                                  : viewCastColor
                              : Colors.grey.shade700),
                    )),
                if (data.specificDate != null)
                  Expanded(
                      flex: 2,
                      child: Text(
                        "${data.specificDate}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: field.value!.contains(data.id)
                                ? Colors.white
                                : viewCastColor,
                            fontWeight: FontWeight.bold),
                      )),
                if (data.specificDate == null)
                  Expanded(
                    flex: 2,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: _getDays(
                        isConflicting,
                        field.value!.contains(data.id),
                        context,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${data.startHour.toString().substring(0, data.startHour.toString().length - 3)} - ${data.endHour.toString().substring(0, data.endHour.toString().length - 3)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isConflicting
                            ? field.value!.contains(data.id)
                                ? Colors.white
                                : viewCastColor
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () => isConflicting ? _updateField(context) : null,
    );
  }

  List<Widget> _getDays(
      bool isConflicting, bool isSelected, BuildContext context) {
    List<Widget> daysList = [];
    for (String day in kDays) {
      daysList.add(
        Expanded(
          child: Text(
            day[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isConflicting
                  ? data.days!.contains(day)
                      ? isSelected
                          ? Colors.white
                          : viewCastColor
                      : isSelected
                          ? viewCastColorLight
                          : Colors.grey.shade300
                  : Colors.grey.shade700,
            ),
          ),
        ),
      );
    }

    return daysList;
  }

  void _updateField(BuildContext context) {
    int index = field.value!.indexWhere((element) => element == data.id);
    List<int> list = List.from(field.value!);
    if (index != -1) {
      list.removeAt(index);
      field.didChange(list);

      _handleRemove(list, context, events);
    } else {
      list.add(data.id!);
      field.didChange(list);

      _handleAdd(data.id!, list, context, events);
    }
  }
}

void _handleRemove(
    List<int> selectedIds, BuildContext context, List<Event> events) {
  context.read(conflictingEventsIds.notifier).state.clear();
  for (var id in selectedIds) {
    _handleAdd(id, selectedIds, context, events);
  }
}

void _handleAdd(
    int id, List<int> selectedIds, BuildContext context, List<Event> events) {
  var selectedEvent =
      events.firstWhere((element) => element.id == id, orElse: () => Event());

  if (selectedEvent.id == null) return;

  // Mode standard
  if (selectedEvent.specificDate != null) {
    for (var event in events.where((element) =>
        !selectedIds.contains(element.id) && element.specificDate != null)) {
      if (selectedEvent.specificDateDateTime!
              .compareTo(event.specificDateDateTime!) ==
          0) {
        if (_isConflictingTime(selectedEvent, event)) {
          context.read(conflictingEventsIds.notifier).state.add(event.id!);
        }
      }
    }
  }
  // Mode récurrent
  else {
    for (var event
        in events.where((element) => !selectedIds.contains(element.id))) {
      if (selectedEvent.days!.any((i) => event.days!.contains(i))) {
        if (_isConflictingTime(selectedEvent, event)) {
          context.read(conflictingEventsIds.notifier).state.add(event.id!);
        }
      }
    }
  }
}

bool _isConflictingTime(Event selectedEvent, Event event) {
  return (selectedEvent.endHourDouble! > event.startHourDouble! &&
      event.endHourDouble! > selectedEvent.startHourDouble!);
}
