import 'package:delivery_kam/features/auth/register/widgets/delivery_auth_register_textfield.dart';
import 'package:flutter/material.dart';

class DeliveryAuthRegisterScreen extends StatefulWidget {
  const DeliveryAuthRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAuthRegisterScreen> createState() =>
      _DeliveryAuthRegisterScreenState();
}

class _DeliveryAuthRegisterScreenState
    extends State<DeliveryAuthRegisterScreen> {
  final double columnHorizontalPadding =
      24.0; // Отступы по бокам столбца кнопок
  final TextEditingController _nameTextFieldController =
      TextEditingController();
  final TextEditingController _phoneTextFieldController =
      TextEditingController();
  final double buttonHeight = 15; // Высота кнопок
  final bottomText =
      "Вы получите на свой телефон сообщение с кодом, чтобы его подтвердить. За отправку сообщения может взиматься дополнительная плата.";
  bool numberIsError = false;

  void toggleTextVisibility() {
    setState(() {
      numberIsError = !numberIsError;
    });
  }

  @override
  void dispose() {
    _nameTextFieldController.dispose();
    _phoneTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: columnHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                DeliveryAuthRegisterTextfield(
                  labelText: "Введите имя",
                  controller: _nameTextFieldController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                DeliveryAuthRegisterTextfield(
                    labelText: 'Введите свой номер телефона',
                    controller: _phoneTextFieldController,
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.none,
                    prefixText: '+7'),
                const Padding(padding: EdgeInsets.only(top: 7)),
                Visibility(
                    visible: numberIsError,
                    child: const Text(
                      "Данный номер телефона уже зарегистрирован, попробуйте ввести другой или восстановить пароль от существующего аккаунта",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "GT-Eesti-Pro-Display",
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(255, 44, 44, 1),
                          height: 0.9),
                    ))
              ]),
              Column(children: [
                Text(
                  bottomText,
                  style: const TextStyle(
                      color: Color.fromRGBO(122, 122, 122, 1),
                      fontFamily: "GT-Eesti-Pro-Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                        backgroundColor:
                            const Color.fromRGBO(195, 195, 195, 1)),
                    onPressed: () {
                      String value1 = _nameTextFieldController.text;
                      String value2 = _phoneTextFieldController.text;
                      toggleTextVisibility();

                      // Делайте что-то с полученными значениями
                      print('Значение из TextField 1: $value1');
                      print('Значение из TextField 2: $value2');
                      Navigator.of(context).pushNamed('/register-confirm');
                    },
                    child: const Text(
                      'Создать аккаунт',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GT-Eesti-Pro-Display",
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ])
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Регистрация",
            style: TextStyle(
              fontFamily: "GT-Eesti-Pro-Display",
              fontSize: 24,
              fontWeight: FontWeight.w400,
            )),
        iconTheme: const IconThemeData(color: Color.fromRGBO(149, 149, 149, 1)),
      ),
      backgroundColor: Colors.white,
    );
  }
}
