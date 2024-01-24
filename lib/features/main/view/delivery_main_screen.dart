import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_unicorn_outline_button.dart';
import 'package:flutter/material.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key});

  @override
  State<DeliveryMainScreen> createState() => _DeliveryMainScreenState();
}

class _DeliveryMainScreenState extends State<DeliveryMainScreen> {
  final double columnHorizontalPadding = 24.0; // Отступы по бокам
  final TextEditingController addressFromTextFieldController =
      TextEditingController();
  final TextEditingController addressToTextFieldController =
      TextEditingController();
  final double maxChildSize = .6;
  final double minChildSize = .1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const DeliveryMainMapScreen(),
      SizedBox.expand(
        child: NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            // Вы можете обработать изменения положения здесь
            if (notification.extent == maxChildSize) {
              print('DraggableScrollableSheet в положении "вытянуто"');
            } else if (notification.extent == minChildSize) {
              print('DraggableScrollableSheet в положении "свернуто"');
            } else {
              print('DraggableScrollableSheet в промежуточном положении');
            }
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: .4,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: columnHorizontalPadding),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Откуда забрать',
                              controller: addressFromTextFieldController,
                              keyboardType: TextInputType.streetAddress,
                              prefixText: "A",
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Куда доставить',
                              controller: addressToTextFieldController,
                              keyboardType: TextInputType.streetAddress,
                              prefixText: "Б",
                            ),
                            const Padding(padding: EdgeInsets.only(top: 25)),
                            Row(
                              children: [
                                Expanded(
                                    child: UnicornOutlineButton(
                                  strokeWidth: 4,
                                  radius: 16,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(175, 223, 233, 1),
                                      Color.fromRGBO(32, 191, 208, 1)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomCenter,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          const Text('Пеший курьер'),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10)),
                                          Image.asset(
                                              "assets/images/main/iconcourier.png"),
                                        ],
                                      )),
                                  onPressed: () {},
                                )),
                                const Padding(
                                    padding: EdgeInsets.only(right: 23)),
                                Expanded(
                                    child: UnicornOutlineButton(
                                  strokeWidth: 4,
                                  radius: 16,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(195, 195, 195, 1),
                                      Color.fromRGBO(195, 195, 195, 1)
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomCenter,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          const Text('Курьер на авто'),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10)),
                                          Image.asset(
                                              "assets/images/main/iconcar.png"),
                                        ],
                                      )),
                                  onPressed: () {},
                                )),
                              ],
                            )
                          ],
                        ),
                      )));
            },
          ),
        ),
      )
    ]));
  }
}
