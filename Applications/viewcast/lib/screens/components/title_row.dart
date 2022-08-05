import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleRow extends StatelessWidget {
  final int flex;
  final String label;
  final List<StateProvider<String>> searchProviders;
  final StateProvider<bool>? editProvider;
  final StateProvider<dynamic>? selectedProvider;
  const TitleRow({
    Key? key,
    required this.flex,
    required this.label,
    required this.searchProviders,
    required this.editProvider,
    required this.selectedProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Material(
                child: IconButton(
                  onPressed: () {
                    for (var provider in searchProviders) {
                      context.read(provider.notifier).state = "";
                    }
                    if (editProvider != null) {
                      context.read(editProvider!.notifier).state = false;
                    }
                    if (selectedProvider != null) {
                      context.read(selectedProvider!.notifier).state = null;
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
