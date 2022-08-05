import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/models/group.dart';
import 'package:viewcast/services/group_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';

class GroupSelectionRow extends StatelessWidget {
  final int flex;
  final Cast? data;
  GroupSelectionRow({
    Key? key,
    required this.flex,
    required this.data,
  }) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FormBuilderField(
        name: "groups",
        initialValue: (data == null) ? List<int>.empty() : data!.groupsIds,
        validator: FormBuilderValidators.required(context),
        autovalidateMode: AutovalidateMode.disabled,
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
                      final responseAsyncValue = watch(filteredAvailableGroups);
                      return responseAsyncValue.map(
                        data: (data) {
                          List<int> selectedIds = field.value!;
                          _sortGroups(data.value, selectedIds);
                          return GridView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
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
                        loading: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (_) => Center(
                          child: Text(
                              CustomLocalizations.of(context).groupListEmpty),
                        ),
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

  void _sortGroups(List<Group> groups, List<int> selectedIds) {
    groups.sort((a, b) =>
        (selectedIds.contains(a.id!)
            ? selectedIds.indexOf(a.id!)
            : double.maxFinite.toInt()) -
        (selectedIds.contains(b.id!)
            ? selectedIds.indexOf(b.id!)
            : double.maxFinite.toInt()));
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
  final Group data;
  final FormFieldState<List<int>> field;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: shadowBorder(16, 16,
            field.value!.contains(data.id) ? viewCastColor : Colors.white),
        child: Stack(
          children: [
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: field.value!.contains(data.id)
                          ? Colors.white
                          : viewCastColor,
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 4.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.displaysCount != null
                            ? data.displaysCount.toString()
                            : data.displayList!.length.toString(),
                        style: TextStyle(
                            color: field.value!.contains(data.id)
                                ? Colors.white
                                : viewCastColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8.0),
                      Icon(Icons.monitor,
                          color: field.value!.contains(data.id)
                              ? Colors.white
                              : viewCastColor),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
