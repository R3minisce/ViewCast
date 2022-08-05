import 'package:flutter/material.dart';
import 'package:viewcast/components/custom_border.dart';
import 'package:viewcast/components/icon_button.dart';

class ListGridView extends StatelessWidget {
  final List data;

  const ListGridView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 40.0,
        left: 40.0,
      ),
      width: double.infinity,
      //color: Colors.blue,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 4,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 4.0,
                      right: 4.0,
                      bottom: 8.0,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: shadowBorder(
                      16,
                      16,
                      Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].username),
                        Text(data[index].uuid),
                        //Text("created on Mon 12st May 2021"),
                      ],
                    )),
              ),
              const SizedBox(width: 8.0),
              Container(
                margin: const EdgeInsets.only(top: 4.0, right: 4.0),
                height: 50,
                width: 50,
                child: IconActionButton(
                  icon: Icons.delete,
                  iconColor: Colors.red,
                  borderFunc: const BoxDecoration(),
                  onTap: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
