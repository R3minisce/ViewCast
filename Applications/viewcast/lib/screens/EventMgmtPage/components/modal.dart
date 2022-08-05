import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/models/view.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/screens/EventMgmtPage/components/ModalItems/form_rows.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/event_service.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';
import 'package:viewcast/styles.dart';

class ModalStruct extends StatelessWidget {
  const ModalStruct({
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
            flex: 10,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const ExPadding(flex: 2),
                ModalBody(flex: 4),
                const ExPadding(flex: 2),
              ],
            ),
          ),
          const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class ModalBody extends StatelessWidget {
  final int flex;
  ModalBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
            Consumer(
              builder: (context, watch, child) {
                var editionMode = watch(editEvent).state;
                var data = watch(selectedEvent).state;
                var isStandardMode = watch(standardProvider).state;

                final responseAsyncValue = watch(getViewsProvider);
                return responseAsyncValue.map(
                    data: (views) {
                      return FormBuilder(
                        key: _formKey,
                        child: Expanded(
                          flex: 30,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              const ExPadding(flex: 1),
                              TitleRow(
                                  flex: 2,
                                  label: (!editionMode)
                                      ? CustomLocalizations.of(context)
                                          .createEvent
                                      : CustomLocalizations.of(context)
                                          .editEvent(data!.name!),
                                  searchProviders: [searchFileProvider],
                                  editProvider: editEvent,
                                  selectedProvider: selectedEvent),
                              const ExPadding(flex: 1),
                              LabelRow(flex: 2, data: data),
                              const ExPadding(flex: 1),
                              ViewRow(
                                views: views.value,
                                viewId: editionMode ? data!.topicId : null,
                              ),
                              const ExPadding(flex: 1),
                              DateSettings(
                                label: isStandardMode
                                    ? CustomLocalizations.of(context)
                                        .standardMode
                                    : CustomLocalizations.of(context)
                                        .recurrentMode,
                                isStandardMode: isStandardMode,
                                data: data,
                                formKey: _formKey,
                              ),
                              const ExPadding(flex: 1),
                              TimerPicker(
                                data: data,
                                formKey: _formKey,
                              ),
                              const ExPadding(flex: 1),
                              Expanded(
                                child:
                                    Consumer(builder: (context, watch, child) {
                                  // ignore: unused_local_variable
                                  var state = watch(errorUpdateProvider).state;
                                  String error = "";
                                  if (_formKey.currentState != null) {
                                    error += (_formKey.currentState!
                                                .fields['minutes']!.errorText !=
                                            null)
                                        ? CustomLocalizations.of(context)
                                                .minuteField +
                                            _formKey.currentState!
                                                .fields['minutes']!.errorText!
                                        : "";
                                    if (error.isNotEmpty) error += "\n";
                                    error += (_formKey.currentState!
                                                .fields['seconds']!.errorText !=
                                            null)
                                        ? CustomLocalizations.of(context)
                                                .secondField +
                                            _formKey.currentState!
                                                .fields['seconds']!.errorText!
                                        : "";
                                  }

                                  return Text(
                                    error,
                                    style: const TextStyle(color: Colors.red),
                                  );
                                }),
                              ),
                              const ExPadding(flex: 1),
                              ValidationRow(
                                  flex: 2,
                                  formKey: _formKey,
                                  isStandardMode: isStandardMode),
                              const ExPadding(flex: 1),
                            ],
                          ),
                        ),
                      );
                    },
                    loading: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_) => Center(
                        child: Text(CustomLocalizations.of(context).error)));
              },
            ),
            const ExPadding(flex: 1),
          ],
        ),
      ),
    );
  }
}

class ValidationRow extends StatelessWidget {
  final int flex;
  final bool isStandardMode;
  const ValidationRow({
    Key? key,
    required this.flex,
    required this.formKey,
    required this.isStandardMode,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: ActionButton(
            label: CustomLocalizations.of(context).validate,
            textColor: Colors.white,
            borderFunc: shadowBorder(32, 32, viewCastColor),
            onPressed: () async => _addOrEditEvent(
                context,
                context.read(refreshEvent),
                context.read(editEvent.notifier).state)),
      ),
    );
  }

  void _addOrEditEvent(
      BuildContext context, var refreshProvider, bool editMode) async {
    if (formKey.currentState!.saveAndValidate()) {
      String label = formKey.currentState!.value['label'];
      String minutes = formKey.currentState!.value['minutes'];
      String seconds = formKey.currentState!.value['seconds'];
      View view = formKey.currentState!.value['views'];

      int timer = int.parse(minutes) * 60 + int.parse(seconds);

      String? date;
      String startHour = "";
      String? days;
      DateTime endTime = formKey.currentState!.value['endTime'];
      String endHour =
          endTime.hour.toString() + ":" + endTime.minute.toString();

      if (isStandardMode) {
        DateTime startDateAndTime =
            formKey.currentState!.value['startDateAndTime'];
        date = startDateAndTime.year.toString() +
            "-" +
            startDateAndTime.month.toString() +
            "-" +
            startDateAndTime.day.toString();
        startHour = startDateAndTime.hour.toString() +
            ":" +
            startDateAndTime.minute.toString();
      } else {
        DateTime startTime = formKey.currentState!.value['startTime'];
        startHour =
            startTime.hour.toString() + ":" + startTime.minute.toString();

        days = formKey.currentState!.value['days'];
      }

      // Création de l'event
      var json = {
        'name': label,
        'start_hour': startHour,
        'end_hour': endHour,
        'specific_date': date,
        'timer': timer,
        'days': days,
        'topic_id': view.id
      };

      if (!editMode) {
        Event? res = await EventService.addEvent(json);
        if (res != null) {
          refreshProvider.state++;
          formKey.currentState!.reset();
          Navigator.of(context).pop();

          showSuccessSnackBar(
              context, CustomLocalizations.of(context).addEventSnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).addEventSnackError);
        }
      } else {
        // Update de l'event

        var editedEvent = context.read(selectedEvent.notifier).state;

        Event temp = Event();
        temp.fromJson(json);

        if (editedEvent!.castId != null) {
          var cast = await context
              .read(getCastProvider.call(editedEvent.castId!).future);

          List<Event> conflictingsEvents =
              _handleConflicts(editedEvent.id!, temp, context, cast.events!);
          if (conflictingsEvents.isNotEmpty) {
            String names = "";
            for (var event in conflictingsEvents) {
              names += event.name! + ", ";
            }

            showErrorSnackBar(
                context,
                CustomLocalizations.of(context)
                    .addEventConflicts(names.substring(0, names.length - 2)));
            context.read(errorUpdateProvider.notifier).state++;
            return;
          }
        }

        bool res = await EventService.updateEvent(json, editedEvent.id!);

        if (res) {
          refreshProvider.state++;
          EventService.notifyUpdateEvent(editedEvent.id!);
          formKey.currentState!.reset();
          context.read(selectedEvent.notifier).state = null;
          context.read(editEvent.notifier).state = false;
          Navigator.of(context).pop();

          showSuccessSnackBar(
              context, CustomLocalizations.of(context).editEventSnackSuccess);
        } else {
          showErrorSnackBar(
              context, CustomLocalizations.of(context).addEventSnackError);
        }
      }
    }
    context.read(errorUpdateProvider.notifier).state++;
  }

  List<Event> _handleConflicts(int editedEventId, Event tempEvent,
      BuildContext context, List<Event> events) {
    // Mode standard
    List<Event> res = [];
    if (tempEvent.specificDate != null) {
      for (var event in events.where((element) =>
          element.id != editedEventId && element.specificDate != null)) {
        if (tempEvent.specificDateDateTime!
                .compareTo(event.specificDateDateTime!) ==
            0) {
          if (_isConflictingTime(tempEvent, event)) {
            res.add(event);
          }
        }
      }
    }
    // Mode récurrent
    else {
      for (var event
          in events.where((element) => element.id != editedEventId)) {
        if (tempEvent.days!.any((i) => event.days!.contains(i))) {
          if (_isConflictingTime(tempEvent, event)) {
            res.add(event);
          }
        }
      }
    }
    return res;
  }

  bool _isConflictingTime(Event tempEvent, Event event) {
    return (tempEvent.endHourDouble! > event.startHourDouble! &&
        event.endHourDouble! > tempEvent.startHourDouble!);
  }
}
