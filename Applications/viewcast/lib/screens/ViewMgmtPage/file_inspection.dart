import 'package:flutter/material.dart';
import 'package:viewcast/models/file.dart';
import 'package:viewcast/models/view.dart';

import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/cache_image_provider.dart';

class FileInspectionRow extends StatelessWidget {
  final int flex;
  final View? data;
  final List<File> files;
  FileInspectionRow({
    Key? key,
    required this.flex,
    required this.data,
    required this.files,
  }) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 15,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: GridView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return GridViewItem(
                      index: index,
                      data: files[index],
                    );
                  },
                )),
          ),
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
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16), right: Radius.circular(16)),
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
          image: CacheImageProvider(
            data.name!,
            data.bytes!,
          ),
        ),
      ),
      child: Container(
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
          style: TextStyle(color: viewCastColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
