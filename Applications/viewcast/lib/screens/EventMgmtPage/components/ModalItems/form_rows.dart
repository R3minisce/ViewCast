import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/models/view.dart';
import 'package:viewcast/providers.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class LabelRow extends StatelessWidget {
  final int flex;
  final Event? data;
  const LabelRow({
    Key? key,
    required this.flex,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: InputFieldCustom(
          name: "label",
          color: Colors.black,
          initialValue: data != null ? data!.name : null,
          hintLabel: CustomLocalizations.of(context).eventLabel,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            FormBuilderValidators.minLength(context, 3),
            FormBuilderValidators.maxLength(context, 50),
          ]),
        ),
      ),
    );
  }
}

class TimerRow extends StatelessWidget {
  final int flex;
  final int max;
  final Event? data;
  final String name;
  final GlobalKey<FormBuilderState> formKey;

  const TimerRow({
    Key? key,
    required this.flex,
    required this.max,
    required this.name,
    required this.formKey,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double initialValue = 0;
    if (data != null) {
      initialValue =
          (name == 'minutes') ? data!.timer! / 60 : data!.timer! % 60;
    }
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: IntputFieldCustom(
          name: name,
          color: Colors.black,
          initialValue: initialValue.toInt().toString(),
          textColor: Colors.black,
          borderFunc: shadowBorder(4, 4, Colors.white),
          validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(context),
              FormBuilderValidators.integer(context),
              FormBuilderValidators.min(context, 0),
              FormBuilderValidators.max(context, max),
              if (name == 'minutes') (value) => _customValidator(context)
            ],
          ),
        ),
      ),
    );
  }

  String? _customValidator(BuildContext context) {
    String minutes = formKey.currentState!.value['minutes'];
    String seconds = formKey.currentState!.value['seconds'];
    if (int.parse(minutes) == 0 && int.parse(seconds) == 0) {
      return CustomLocalizations.of(context).cannotBeZERO;
    }
  }
}

class DateRow extends StatelessWidget {
  final String name;
  final InputType mode;
  final String hintLabel;
  final DateTime? initialValue;
  final GlobalKey<FormBuilderState> formKey;
  const DateRow({
    Key? key,
    required this.name,
    required this.mode,
    required this.hintLabel,
    required this.formKey,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: DateFieldCustom(
            hintLabel: hintLabel,
            initialValue: initialValue,
            name: name,
            color: Colors.white,
            borderFunc: shadowBorder(32, 32, Colors.white),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              if (name == 'startTime' || name == 'startDateAndTime')
                (value) => _customValidator(context)
            ]),
            mode: mode),
      ),
    );
  }

  String? _customValidator(BuildContext context) {
    DateTime start = (name == 'startTime')
        ? formKey.currentState!.value['startTime']
        : formKey.currentState!.value['startDateAndTime'];
    DateTime end = formKey.currentState!.value['endTime'];
    var startTimeOfDay = TimeOfDay.fromDateTime(start);
    var endTimeOfDay = TimeOfDay.fromDateTime(end);

    if ((startTimeOfDay.hour + startTimeOfDay.minute / 60) >=
        (endTimeOfDay.hour + endTimeOfDay.minute / 60)) {
      return CustomLocalizations.of(context).cannotHappenBefore;
    }
  }
}

class ModeButton extends StatelessWidget {
  const ModeButton({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const ExPadding(flex: 4),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: ActionButton(
                  label: label,
                  textColor: Colors.white,
                  borderFunc: shadowBorder(32, 32, viewCastColor),
                  onPressed: () {
                    context.read(standardProvider).state =
                        !context.read(standardProvider).state;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerPicker extends StatelessWidget {
  const TimerPicker({
    Key? key,
    this.data,
    required this.formKey,
  }) : super(key: key);

  final Event? data;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const SizedBox(width: 4.0),
          Text(CustomLocalizations.of(context).frequency,
              style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 16.0),
          TimerRow(
            flex: 2,
            data: data,
            max: 60,
            name: "minutes",
            formKey: formKey,
          ),
          const SizedBox(width: 16.0),
          Text(CustomLocalizations.of(context).minutes,
              style: const TextStyle(fontSize: 16)),
          const ExPadding(flex: 1),
          TimerRow(
            flex: 2,
            data: data,
            max: 59,
            name: "seconds",
            formKey: formKey,
          ),
          const SizedBox(width: 16.0),
          Text(CustomLocalizations.of(context).seconds,
              style: const TextStyle(fontSize: 16)),
          const ExPadding(flex: 10),
        ],
      ),
    );
  }
}

class DateSettings extends StatelessWidget {
  final String label;
  final bool isStandardMode;
  final Event? data;
  final GlobalKey<FormBuilderState> formKey;

  const DateSettings({
    Key? key,
    required this.label,
    required this.isStandardMode,
    this.data,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? start;
    DateTime? end;
    String? year;
    String? month;
    String? day;

    if (data != null) {
      String startHour = data!.startHour!.split(":")[0];
      String startMinute = data!.startHour!.split(":")[1];
      String endHour = data!.endHour!.split(":")[0];
      String endMinute = data!.endHour!.split(":")[1];

      if (isStandardMode && data!.specificDate != null) {
        year = data!.specificDate!.split("-")[0];
        month = data!.specificDate!.split("-")[1];
        day = data!.specificDate!.split("-")[2];

        start = DateTime(int.parse(year), int.parse(month), int.parse(day),
            int.parse(startHour), int.parse(startMinute));
        end = DateTime(int.parse(year), int.parse(month), int.parse(day),
            int.parse(endHour), int.parse(endMinute));
      } else {
        DateTime now = DateTime.now();
        start = DateTime(now.year, now.month, now.day, int.parse(startHour),
            int.parse(startMinute));
        end = DateTime(now.year, now.month, now.day, int.parse(endHour),
            int.parse(endMinute));
      }
    }

    return Expanded(
      flex: 6,
      child: Flex(
        direction: Axis.vertical,
        children: [
          ModeButton(
            label: label,
          ),
          if (!isStandardMode)
            Expanded(
              flex: 2,
              child: Center(
                child: FormBuilderFilterChip(
                  name: "days",
                  initialValue:
                      (data != null) ? data!.days! : List<String>.empty(),
                  spacing: 2.0,
                  checkmarkColor: Colors.white,
                  backgroundColor: Colors.grey.shade400,
                  selectedColor: viewCastColor,
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  options: List.generate(
                    kDays.length,
                    (index) => FormBuilderFieldOption(value: kDays[index]),
                  ),
                  valueTransformer: (value) {
                    String b = "";
                    for (var day in kDays) {
                      b += value!.contains(day) ? "1" : "0";
                    }

                    return b;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required<List<String>>(context),
                  ]),
                ),
              ),
            ),
          if (isStandardMode) const ExPadding(flex: 1),
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                DateRow(
                  name: isStandardMode ? 'startDateAndTime' : 'startTime',
                  mode: isStandardMode ? InputType.both : InputType.time,
                  hintLabel: CustomLocalizations.of(context).selectStartDate,
                  initialValue: start,
                  formKey: formKey,
                ),
                const ExPadding(flex: 1),
                DateRow(
                  name: 'endTime',
                  mode: InputType.time,
                  hintLabel: CustomLocalizations.of(context).selectEndDate,
                  initialValue: end,
                  formKey: formKey,
                ),
              ],
            ),
          ),
          if (isStandardMode) const ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class ViewRow extends StatelessWidget {
  const ViewRow({Key? key, required this.views, this.viewId}) : super(key: key);
  final List<View> views;
  final int? viewId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ViewSelectionCustom(
        name: 'views',
        color: Colors.black,
        borderFunc: shadowBorder(32, 32, Colors.white),
        hintLabel: CustomLocalizations.of(context).selectView,
        views: views,
        initialValue: viewId != null
            ? views.firstWhere((element) => element.id == viewId)
            : null,
        validator: FormBuilderValidators.required(context),
      ),
    );
  }
}
