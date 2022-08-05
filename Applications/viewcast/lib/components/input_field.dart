import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/view.dart';

class InputFieldCustom extends StatelessWidget {
  final Color color;
  final String name;
  final String hintLabel;
  final Color textColor;
  final Decoration borderFunc;
  final bool isVisible;
  final bool isSecret;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const InputFieldCustom(
      {Key? key,
      required this.name,
      required this.color,
      required this.hintLabel,
      required this.textColor,
      required this.borderFunc,
      required this.isVisible,
      required this.isSecret,
      this.validator,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Container(
        decoration: borderFunc,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: name,
                  initialValue: initialValue,
                  validator: validator,
                  obscureText: isSecret,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintLabel,
                    hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  ),
                  style: TextStyle(color: textColor, fontSize: 16.0),
                ),
              ),
              Visibility(
                  child: Icon(
                    Icons.search,
                    color: textColor,
                  ),
                  visible: isVisible)
            ],
          ),
        ),
      ),
    );
  }
}

class IntputFieldCustom extends StatelessWidget {
  final Color color;
  final String name;
  final Color textColor;
  final Decoration borderFunc;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const IntputFieldCustom(
      {Key? key,
      required this.name,
      required this.color,
      required this.textColor,
      required this.borderFunc,
      this.validator,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Container(
        decoration: borderFunc,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: FormBuilderTextField(
                    name: name,
                    initialValue: initialValue,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    validator: validator,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                        errorText: null,
                        errorStyle: const TextStyle(
                            color: Colors.transparent, fontSize: 1),
                        counterText: ""),
                    style: TextStyle(color: textColor, fontSize: 24.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFieldCustom extends StatelessWidget {
  final Color color;
  final String name;
  final Decoration borderFunc;
  final InputType mode;
  final String hintLabel;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final void Function(String?)? onChanged;

  const DateFieldCustom(
      {Key? key,
      required this.name,
      required this.color,
      required this.borderFunc,
      required this.mode,
      required this.hintLabel,
      this.validator,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Container(
        decoration: borderFunc,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: name,
                  inputType: mode,
                  initialValue: initialValue,
                  alwaysUse24HourFormat: true,
                  validator: validator,
                  decoration: InputDecoration(
                      hintText: hintLabel,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      counterText: ""),
                  style: const TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewSelectionCustom extends StatelessWidget {
  final Color color;
  final String name;
  final Decoration borderFunc;
  final String hintLabel;
  final List<View> views;
  final String? Function(View?)? validator;
  final void Function(String?)? onChanged;
  final View? initialValue;

  const ViewSelectionCustom({
    Key? key,
    required this.name,
    required this.color,
    required this.borderFunc,
    required this.hintLabel,
    required this.views,
    required this.initialValue,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Container(
        decoration: borderFunc,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FormBuilderSearchableDropdown(
                  initialValue: initialValue,
                  itemAsString: (View? view) =>
                      "${view!.name!} - ${view.filesCount} ${CustomLocalizations.of(context).files}",
                  name: name,
                  items: views,
                  decoration: InputDecoration(
                      hintText: hintLabel,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      counterText: ""),
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
