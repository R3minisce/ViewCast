import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/icon_button.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/file.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/styles.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Consumer(
          builder: (context, watch, child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.transparent,
              child: IconActionButton(
                iconColor: Colors.white,
                icon: Icons.upload,
                borderFunc: shadowBorder(
                  32,
                  32,
                  viewCastColor,
                ),
                onTap: () => _uploadFile(context, watch),
              ),
            );
          },
        ),
      ),
    );
  }

  void _uploadFile(BuildContext context, watch) async {
    var extensions = ['jpg', 'png', 'jpeg', 'gif'];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null) {
      List<File> selected = [];
      for (var file in result.files) {
        String? ext = file.extension?.toLowerCase();
        String? name;
        int index = file.name.lastIndexOf('.');
        if (index != -1) {
          name = file.name.substring(0, index);
        }

        if (extensions.contains(ext) && file.size <= 4000000) {
          selected.add(
            File(
              name: name,
              type: ext,
              bytesString: base64.encode(file.bytes as List<int>),
            ),
          );
        }
      }

      for (File file in selected) {
        await FileService.addFile(file);
      }
      if (selected.isNotEmpty) {
        watch(refreshFile.notifier).state++;
      } else {
        var snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
          content: Text(
            CustomLocalizations.of(context).fileSizeExt,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.red),
          ),
        );

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {}
  }
}
