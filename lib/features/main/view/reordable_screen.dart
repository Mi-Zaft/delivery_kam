import 'package:flutter/material.dart';

class ReordableScreen extends StatefulWidget {
  const ReordableScreen({super.key});

  @override
  State<ReordableScreen> createState() => _ReordableScreenState();
}

class _ReordableScreenState extends State<ReordableScreen> {
  List<String> items = List.generate(10, (index) => "Item ${index + 1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Drag & Drop в ListView'),
      ),
      body: ReorderableListView(
        physics: const NeverScrollableScrollPhysics(),
        children: items
            .map((item) => ListTile(
                  key: Key(item),
                  title: Text(item),
                ))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final String item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
