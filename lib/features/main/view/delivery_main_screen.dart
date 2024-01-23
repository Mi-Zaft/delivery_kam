import 'package:flutter/material.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key});

  @override
  State<DeliveryMainScreen> createState() => _DeliveryMainScreenState();
}

class _DeliveryMainScreenState extends State<DeliveryMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ListView(
        children: [
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
          ListTile(title: Text('qweq')),
        ],
      ),
      SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: .4,
          minChildSize: .1,
          maxChildSize: .6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.blue[100],
              child: ListView.builder(
                controller: scrollController,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            );
          },
        ),
      ),
    ])
        // body: SizedBox.expand(
        //   child: DraggableScrollableSheet(
        //     maxChildSize: 1,
        //     builder: (BuildContext context, ScrollController scrollController) {
        //       return Container(
        //         color: Colors.blue[100],
        //         child: ListView.builder(
        //           controller: scrollController,
        //           itemCount: 5,
        //           itemBuilder: (BuildContext context, int index) {
        //             return ListTile(title: Text('Item $index'));
        //           },
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
