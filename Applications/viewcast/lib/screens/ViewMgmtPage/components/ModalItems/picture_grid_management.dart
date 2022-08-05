import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';

import 'package:viewcast/models/file.dart';

import 'package:viewcast/screens/ViewMgmtPage/components/ModalItems/upload_button.dart';
import 'package:viewcast/screens/components/buttons.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/view_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/screens/components/snackbars.dart';
import 'package:viewcast/utils/cache_image_provider.dart';

class GridStruct extends StatelessWidget {
  final int flex;

  const GridStruct({
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
          GridViewBody(flex: 25),
          ExPadding(flex: 1),
          UploadButton()
        ],
      ),
    );
  }
}

class GridViewBody extends StatelessWidget {
  final int flex;
  const GridViewBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 16,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Consumer(
                builder: (context, watch, child) {
                  final responseAsyncValue = watch(filteredFiles);
                  return responseAsyncValue.map(
                    data: (data) {
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
          const ExPadding(flex: 1),
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
  final File data;

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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                height: 30,
                width: double.maxFinite,
                child: Text(
                  data.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: viewCastColor, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
      ),
      onTap: () => _delete(data, context),
    );
  }

  void _delete(File file, BuildContext context) {
    Widget cancelButton = const CancelButton();
    Widget continueButton = const ContinueButton();

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(CustomLocalizations.of(context).warning),
      content: Text(CustomLocalizations.of(context).warningDeleteFile),
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
    confirmation.then(
      (value) async {
        if (value != null && value) {
          var success = await FileService.deleteFile(file.id!);
          if (success) {
            context.read(refreshFile.notifier).state++;
            context.read(refreshView.notifier).state++;

            showSuccessSnackBar(context,
                CustomLocalizations.of(context).deleteFileSnackSuccess);
          } else {
            showErrorSnackBar(
                context, CustomLocalizations.of(context).deleteFileSnackError);
          }
        }
      },
    );
  }
}
