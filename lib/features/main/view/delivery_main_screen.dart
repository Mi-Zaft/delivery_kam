import 'package:delivery_kam/features/main/view/delivery_main_map_screen.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_custom_checkbox_list_tile.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_textfield_address.dart';
import 'package:delivery_kam/features/main/widgets/delivery_main_unicorn_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final TextEditingController senderNumberTextFieldController =
      TextEditingController();
  final TextEditingController senderNameTextFieldController =
      TextEditingController();
  final TextEditingController recipientNumberTextFieldController =
      TextEditingController();
  final TextEditingController recipientNameTextFieldController =
      TextEditingController();
  final TextEditingController subjectTextFieldController =
      TextEditingController();
  final TextEditingController diamondTextFieldController =
      TextEditingController();
  final TextEditingController weightTextFieldController =
      TextEditingController();
  final TextEditingController envelopeTextFieldController =
      TextEditingController();
  final TextEditingController chatTextFieldController = TextEditingController();

  final double maxChildSize = 0.9;
  final double minChildSize = .425;

  bool _isFragileCargo = false;
  bool _isThermalBag = false;
  bool _isRegistrationInTransportCompany = false;
  bool _isCorrespondenceInRussianPostOffice = false;

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.only(top: 24)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 24)),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/main/iconavatar.png',
                      width: 60,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 24)),
                Container(
                  width: 150,
                  child: const Text(
                    'Дарья',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            GestureDetector(
              child: ListTile(
                onTap: () => {Navigator.of(context).pushNamed('/payment-list')},
                leading: Image.asset(
                  'assets/images/main/wallet.png',
                ),
                title: const Text(
                  'Способы оплаты',
                  style: TextStyle(
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () => {},
                leading: Image.asset(
                  'assets/images/main/becomeCourier.png',
                ),
                title: const Text(
                  'Стать курьером',
                  style: TextStyle(
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () => {},
                leading: Image.asset(
                  'assets/images/main/chat.png',
                ),
                title: const Text(
                  'Служба поддержки',
                  style: TextStyle(
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () => {},
                leading: Image.asset(
                  'assets/images/main/exit.png',
                ),
                title: const Text(
                  'Выйти из аккаунта',
                  style: TextStyle(
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(bottom: 25.0, top: 10, left: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed("/register");
              print('Укажите адрес');
              print(_isFragileCargo);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              "Укажите адрес",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "GT-Eesti-Pro-Display",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        DeliveryMainMapScreen(openDrawer: openDrawer),
        SizedBox.expand(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
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
              initialChildSize: .425,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          spreadRadius: 5,
                          blurRadius: 5,
                        )
                      ]),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: columnHorizontalPadding),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldAddress(
                                labelText: 'Откуда забрать',
                                prefixStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(122, 122, 122, 1),
                                ),
                                controller: addressFromTextFieldController,
                                keyboardType: TextInputType.streetAddress,
                                prefixText: "A"),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Куда доставить',
                              prefixStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(122, 122, 122, 1),
                              ),
                              controller: addressToTextFieldController,
                              keyboardType: TextInputType.streetAddress,
                              prefixText: "Б",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
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
                                                EdgeInsets.only(bottom: 10),
                                          ),
                                          Image.asset(
                                              "assets/images/main/iconcourier.png"),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                ),
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
                                                EdgeInsets.only(bottom: 10),
                                          ),
                                          Image.asset(
                                              "assets/images/main/iconcar.png"),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Время доставки',
                                style: TextStyle(
                                  color: Color.fromRGBO(93, 105, 114, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "GT-Eesti-Pro-Display",
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Обычная',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily:
                                                  "GT-Eesti-Pro-Display",
                                            ),
                                          ),
                                          Text(
                                            '2-5 часов',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              fontFamily:
                                                  "GT-Eesti-Pro-Display",
                                              color: Color.fromRGBO(
                                                  93, 105, 114, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                ),
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Экспресс',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily:
                                                  "GT-Eesti-Pro-Display",
                                            ),
                                          ),
                                          Text(
                                            'Самая быстрая',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              fontFamily:
                                                  "GT-Eesti-Pro-Display",
                                              color: Color.fromRGBO(
                                                  93, 105, 114, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Как доставить',
                                style: TextStyle(
                                  color: Color.fromRGBO(93, 105, 114, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "GT-Eesti-Pro-Display",
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: UnicornOutlineButton(
                                    height:
                                        MediaQuery.of(context).size.width <= 350
                                            ? 90
                                            : 60,
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
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            // padding:
                                            // const EdgeInsets.symmetric(
                                            //     horizontal: 5),
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    350
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            child: const Text(
                                              'Выйти к машине',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontFamily:
                                                    "GT-Eesti-Pro-Display",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    300
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            child: const Text(
                                              'При отправке и получении',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                fontFamily:
                                                    "GT-Eesti-Pro-Display",
                                                color: Color.fromRGBO(
                                                    93, 105, 114, 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                ),
                                Expanded(
                                  child: UnicornOutlineButton(
                                    strokeWidth: 4,
                                    radius: 16,
                                    height:
                                        MediaQuery.of(context).size.width <= 350
                                            ? 90
                                            : 60,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(195, 195, 195, 1),
                                        Color.fromRGBO(195, 195, 195, 1)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomCenter,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context)
                                                  .size
                                                  .width <=
                                              300
                                          ? MediaQuery.of(context).size.width *
                                              0.3
                                          : MediaQuery.of(context).size.width *
                                              0.4,
                                      child: const Text(
                                        'От двери до двери',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontFamily: "GT-Eesti-Pro-Display",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Введите номер телефона отправителя',
                                style: TextStyle(
                                  color: Color.fromRGBO(93, 105, 114, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "GT-Eesti-Pro-Display",
                                ),
                              ),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: '',
                              controller: senderNumberTextFieldController,
                              maskInputFormatters: [phoneMaskFormatter],
                              prefixStyle: const TextStyle(
                                fontFamily: "GT-Eesti-Pro-Display",
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.phone,
                              prefixText: "+7",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldAddress(
                                labelText: 'Введите имя отправителя',
                                controller: senderNameTextFieldController,
                                keyboardType: TextInputType.name),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Введите номер телефона получателя',
                                style: TextStyle(
                                  color: Color.fromRGBO(93, 105, 114, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "GT-Eesti-Pro-Display",
                                ),
                              ),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: '',
                              controller: recipientNumberTextFieldController,
                              maskInputFormatters: [phoneMaskFormatter],
                              prefixStyle: const TextStyle(
                                  fontFamily: "GT-Eesti-Pro-Display",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.phone,
                              prefixText: "+7",
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            DeliveryMainTextfieldAddress(
                                labelText: 'Введите имя получателя',
                                controller: recipientNameTextFieldController,
                                keyboardType: TextInputType.name),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Детали отправки',
                                style: TextStyle(
                                    fontFamily: "GT-Eesti-Pro-Display",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Предмет доставки',
                              controller: subjectTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontFamily: "GT-Eesti-Pro-Display",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.phone,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconbox.png",
                              ),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Комментарий курьеру',
                              controller: envelopeTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontFamily: "GT-Eesti-Pro-Display",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.phone,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconEnvelope.png",
                              ),
                            ),
                            DeliveryMainTextfieldAddress(
                              labelText: 'Сообщение получателю',
                              controller: chatTextFieldController,
                              prefixStyle: const TextStyle(
                                  fontFamily: "GT-Eesti-Pro-Display",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              keyboardType: TextInputType.phone,
                              prefixIcon: Image.asset(
                                "assets/images/main/iconChat.png",
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Дополнительно',
                                style: TextStyle(
                                    fontFamily: "GT-Eesti-Pro-Display",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       value: false,
                            //       onChanged: (bool? value) {
                            //         setState(() {});
                            //       },
                            //     ),
                            //     const Text(
                            //         'Доставка без оформления квитанции')
                            //   ],
                            // ),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isFragileCargo,
                                label: 'Хрупкий груз',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isFragileCargo = newValue!;
                                  });
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isThermalBag,
                                label: 'Наличие термосумки',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isThermalBag = newValue!;
                                  });
                                }),
                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isRegistrationInTransportCompany,
                                label:
                                    'Оформление отправления в транспортной компании',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isRegistrationInTransportCompany =
                                        newValue!;
                                  });
                                }),

                            DeliveryMainCustomCheckboxListTile(
                                isChecked: _isCorrespondenceInRussianPostOffice,
                                label:
                                    'Отправка/получение корреспонденции в отделениях Почты России',
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isCorrespondenceInRussianPostOffice =
                                        newValue!;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
