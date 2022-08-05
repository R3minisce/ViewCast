import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/screens/EventMgmtPage/components/modal.dart';
import 'package:viewcast/screens/ViewMgmtPage/inspect_files.dart';
import 'package:viewcast/screens/components/buttons.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/row_item.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/services/event_service.dart';
import 'package:viewcast/services/view_service.dart';
import 'package:viewcast/styles.dart';

class ListRow extends StatelessWidget {
  final int flex;

  const ListRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          ExPadding(flex: 1),
          ListBody(flex: 24),
          ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class ListBody extends StatelessWidget {
  final int flex;

  const ListBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Consumer(
        builder: (context, watch, child) {
          final responseAsyncValue = watch(filteredEvents);
          final refreshEventProvider = watch(refreshEvent);

          return responseAsyncValue.map(
            data: (data) {
              return ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, i) {
                  return ListViewItem(
                      index: i,
                      data: data.value[i],
                      refreshEventProvider: refreshEventProvider);
                },
              );
            },
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (_) =>
                Center(child: Text(CustomLocalizations.of(context).error)),
          );
        },
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final StateController<int> refreshEventProvider;
  final Event data;
  final int index;

  const ListViewItem({
    Key? key,
    required this.refreshEventProvider,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: shadowBorder(8, 8, Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          RowItem(label: "${index + 1}", flex: 1),
          RowItem(label: data.name!, flex: 2),
          RowItem(label: data.specificDate ?? "", flex: 2),
          DayItem(flex: 3, days: data.days!),
          const RowItem(label: "", flex: 1),
          RowItem(
              label: data.startHour
                  .toString()
                  .substring(0, data.startHour.toString().length - 3),
              flex: 2),
          RowItem(
              label: data.endHour
                  .toString()
                  .substring(0, data.endHour.toString().length - 3),
              flex: 2),
          Expanded(
            flex: 2,
            child: data.topicId == null
                ? Container()
                : Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          child: IconButton(
                            splashColor: Colors.blue.shade100,
                            icon: Icon(Icons.search, color: viewCastColor),
                            onPressed: () => _inspectFiles(data, context),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          RowItem(label: data.timer.toString(), flex: 2),
          Material(
            child: IconButton(
              splashColor: Colors.blue.shade100,
              icon: Icon(Icons.copy, color: viewCastColor),
              onPressed: () => _duplicate(data, context),
            ),
          ),
          Material(
            child: IconButton(
              splashColor: Colors.blue.shade100,
              icon: Icon(Icons.edit, color: viewCastColor),
              onPressed: () => _update(data, context),
            ),
          ),
          Material(
            child: IconButton(
              splashColor: Colors.blue.shade100,
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _delete(data, context),
            ),
          ),
        ],
      ),
    );
  }

  void _inspectFiles(Event event, BuildContext context) async {
    var viewFull = await context
        .read(getViewWithFilesProvider.call(event.topicId!).future);
    context.read(selectedView.notifier).state = viewFull;

    showDialog(
      context: context,
      builder: (BuildContext context) => const PopUpFilesStruct(),
    );
  }

  void _duplicate(Event event, BuildContext context) async {
    String temp = randomAlphaNumeric(4);

    String formattedDays = "";
    for (var day in kDays) {
      formattedDays += event.days!.contains(day) ? "1" : "0";
    }
    Event? res = await EventService.addEvent(
      {
        'name': "${event.name}-$temp",
        'start_hour': event.startHour,
        'end_hour': event.endHour,
        'specific_date': event.specificDate,
        'timer': event.timer,
        'days': formattedDays,
        'topic_id': event.topicId
      },
    );

    if (res != null) {
      refreshEventProvider.state++;

      showSuccessSnackBar(
          context, CustomLocalizations.of(context).copyEventSnackSucess);
    } else {
      showErrorSnackBar(
          context, CustomLocalizations.of(context).addEventSnackError);
    }
  }

  void _update(Event event, BuildContext context) {
    context.read(editEvent.notifier).state = true;
    context.read(selectedEvent.notifier).state = event;
    EventService.notifyUpdateEvent(event.id!);
    context.read(standardProvider).state = (event.specificDate != null);
    showDialog(
      context: context,
      builder: (BuildContext context) => const ModalStruct(),
    );
  }

  void _delete(Event event, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteEvent),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    Future confirmation = showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    confirmation.then((value) async {
      if (value != null && value) {
        var success = await EventService.deleteEvent(event.id!);
        if (success) {
          refreshEventProvider.state++;
          EventService.notifyDeleteEvent(event.id!);
          showSuccessSnackBar(
              context, CustomLocalizations.of(context).deleteEventSnackSucess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).addEventSnackError);
        }
      }
    });
  }
}
