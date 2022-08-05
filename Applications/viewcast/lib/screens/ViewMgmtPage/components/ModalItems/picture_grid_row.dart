import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';

import 'package:viewcast/models/file.dart';
import 'package:viewcast/models/view.dart';

import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/form_builder_validators/form_builder_validators.dart';
import 'package:viewcast/utils/cache_image_provider.dart';

class GridStruct extends StatelessWidget {
  final int flex;
  final View? data;

  const GridStruct({
    Key? key,
    required this.flex,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          GridViewBody(flex: 27, data: data),
        ],
      ),
    );
  }
}

class GridViewBody extends StatelessWidget {
  final int flex;
  final View? data;
  const GridViewBody({
    Key? key,
    this.data,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FormBuilderField(
        name: "files",
        initialValue: (data == null) ? List<int>.empty() : data!.filesIds,
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
                      final responseAsyncValue = watch(filteredFiles);
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
                              crossAxisCount: 5,
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
  final File data;
  final FormFieldState<List<int>> field;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ResizeImage(
                CacheImageProvider(
                  data.name!,
                  data.bytes!,
                ),
                width: 192,
                height: 108),
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  (field.value!.contains(data.id) ? "${index + 1}" : ""),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: (field.value!.contains(data.id)
                      ? viewCastColor
                      : Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: field.value!.contains(data.id)
                      ? viewCastColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                height: 30,
                width: double.maxFinite,
                child: Text(
                  data.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: field.value!.contains(data.id)
                          ? Colors.white
                          : viewCastColor,
                      fontWeight: FontWeight.bold),
                ),
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
