import 'package:flutter/material.dart';

class DisplayGridView extends StatelessWidget {
  const DisplayGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          right: 40.0, left: 40.0, top: 80.0, bottom: 40.0),
      width: double.infinity,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 1.5,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Display ${index + 1}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8.0),
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(0.75),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
