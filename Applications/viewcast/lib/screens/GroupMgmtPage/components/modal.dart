import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:viewcast/components/action_button.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/input_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/models/group.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/screens/components/title_row.dart';
import 'package:viewcast/services/display_service.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';
import 'package:viewcast/utils/utils.dart';

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
            flex: 16,
            child: Container(
                color: Colors.transparent,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const ExPadding(flex: 2),
                    ModalBody(flex: 10),
                    const ExPadding(flex: 2),
                  ],
                )),
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
                var editionMode = watch(editGroup).state;
                var data = watch(selectedGroup.notifier).state;
                return Expanded(
                  flex: 30,
                  child: FormBuilder(
                    key: _formKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        const ExPadding(flex: 1),
                        TitleRow(
                          flex: 2,
                          label: (!editionMode)
                              ? CustomLocalizations.of(context).createGroup
                              : CustomLocalizations.of(context)
                                  .editGroup(data!.name!),
                          searchProviders: [searchDisplayProvider],
                          editProvider: editGroup,
                          selectedProvider: selectedGroup,
                        ),
                        const ExPadding(flex: 1),
                        LabelRow(flex: 2, data: data),
                        const ExPadding(flex: 1),
                        const SearchRow(flex: 2),
                        const ExPadding(flex: 1),
                        GridBody(flex: 17, group: data),
                        ValidationRow(flex: 2, formKey: _formKey),
                        const ExPadding(flex: 1),
                      ],
                    ),
                  ),
                );
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
  const ValidationRow({
    Key? key,
    required this.flex,
    required this.formKey,
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
          onPressed: () => !context.read(editGroup).state
              ? _addGroup(context, context.read(refreshGroup))
              : _editGroup(context, context.read(refreshGroup)),
        ),
      ),
    );
  }

  _addGroup(BuildContext context, refreshGroupProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      var displays = formKey.currentState!.value['displays'];

      Group? res = await GroupService.addGroup(label, displays);
      if (res != null) {
        refreshGroupProvider.state++;
        formKey.currentState!.reset();
        Navigator.of(context).pop();
        showSuccessSnackBar(
          context,
          CustomLocalizations.of(context).addGroupSnackSuccess,
        );
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).addGroupSnackError);
      }
    }
  }

  _editGroup(BuildContext context, refreshGroupProvider) async {
    if (formKey.currentState!.saveAndValidate()) {
      var label = formKey.currentState!.value['label'];
      List<int> displays = formKey.currentState!.value['displays'];
      var editedGroup = context.read(selectedGroup.notifier).state;

      var res = await GroupService.updateGroup({
        "name": label,
        "displays_ids": displays,
      }, editedGroup!.id!);
      if (res) {
        refreshGroupProvider.state++;
        var impactedDisplays = editedGroup.displayList!
            .map((e) => e.id)
            .toSet()
            .difference(displays.toSet())
            .union(displays
                .toSet()
                .difference(editedGroup.displayList!.map((e) => e.id).toSet()));

        for (var element in impactedDisplays) {
          DisplayService.notifyUpdateDisplay(element!);
        }
        formKey.currentState!.reset();
        context.read(searchDisplayProvider.notifier).state = "";
        context.read(selectedGroup.notifier).state = null;
        context.read(editGroup.notifier).state = false;
        Navigator.of(context).pop();
        showSuccessSnackBar(
          context,
          CustomLocalizations.of(context).editGroupSnackSuccess,
        );
      } else {
        showErrorSnackBar(
            context, CustomLocalizations.of(context).editGroupSnackError);
      }
    }
  }
}

class GridBody extends StatelessWidget {
  final int flex;
  final Group? group;
  const GridBody({
    Key? key,
    required this.flex,
    this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FormBuilderField(
        name: "displays",
        initialValue: (group == null)
            ? List<int>.empty()
            : group!.displayList!.map((e) => e.id!).toList(),
        autovalidateMode: AutovalidateMode.disabled,
        validator: FormBuilderValidators.required(context),
        builder: (FormFieldState<List<int>> field) {
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final responseAsyncValue =
                          watch(filteredGrouplessDisplays);
                      return responseAsyncValue.map(
                        data: (data) {
                          List<int> selectedIds = field.value!;
                          data.value.sort((a, b) =>
                              (selectedIds.contains(a.id!)
                                  ? selectedIds.indexOf(a.id!)
                                  : double.maxFinite.toInt()) -
                              (selectedIds.contains(b.id!)
                                  ? selectedIds.indexOf(b.id!)
                                  : double.maxFinite.toInt()));
                          return GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: data.value.length,
                            itemBuilder: (context, index) {
                              return GridViewItem(
                                index: index,
                                data: data.value[index],
                                field: field,
                              );
                            },
                          );
                        },
                        loading: (_) =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_) => Center(
                            child: Text(CustomLocalizations.of(context).error)),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(field.errorText ?? "",
                      style: const TextStyle(color: Colors.red)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    Key? key,
    required this.index,
    required this.data,
    required this.field,
  }) : super(key: key);

  final int index;
  final Display data;
  final FormFieldState<List<int>> field;

  @override
  Widget build(BuildContext context) {
    DateTime date = data.creationTime!.toLocal();
    String minute = Utils.formatMinute(date);
    String month = Utils.formatMonth(date);
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: shadowBorder(16, 16,
            field.value!.contains(data.id) ? viewCastColor : Colors.white),
        child: Stack(children: [
          if (field.value!.contains(data.id))
            Container(
              padding: const EdgeInsets.only(top: 4.0, right: 4.0),
              width: double.maxFinite,
              alignment: Alignment.topRight,
              child: const Icon(Icons.check, color: Colors.white, size: 30),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  data.name ?? CustomLocalizations.of(context).noName,
                  style: TextStyle(
                      color: field.value!.contains(data.id)
                          ? Colors.white
                          : viewCastColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  "${date.day}/$month/${date.year} ${date.hour}:$minute",
                  style: TextStyle(
                      color: field.value!.contains(data.id)
                          ? Colors.white
                          : viewCastColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ]),
      ),
      onTap: () => _updateField(),
    );
  }

  void _updateField() {
    int index = field.value!.indexWhere((element) => element == data.id);
    List<int> list = List.from(field.value!);
    if (index != -1) {
      list.removeAt(index);
      field.didChange(list);
    } else {
      list.add(data.id!);
      field.didChange(list);
    }
  }
}

class SearchRow extends StatelessWidget {
  final int flex;
  const SearchRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: InputFieldCustom(
          name: "search",
          color: Colors.black,
          hintLabel: CustomLocalizations.of(context).search,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: true,
          isSecret: false,
          onChanged: (data) {
            context.read(searchDisplayProvider).state = data!;
          },
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final int flex;
  final Group? data;
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
          initialValue: data != null ? data!.name : null,
          color: Colors.black,
          hintLabel: CustomLocalizations.of(context).groupLabel,
          textColor: Colors.black,
          borderFunc: shadowBorder(32, 32, Colors.white),
          isVisible: false,
          isSecret: false,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 5),
            FormBuilderValidators.maxLength(context, 20),
          ]),
        ),
      ),
    );
  }
}
