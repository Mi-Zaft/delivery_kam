import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeliveryPaymentAddScreen extends StatefulWidget {
  const DeliveryPaymentAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveryPaymentAddScreenState();
}

class _DeliveryPaymentAddScreenState extends State<DeliveryPaymentAddScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  var cardMaskFormatter = MaskTextInputFormatter(
      mask: '####-####-####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var cvvMaskFormatter = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая карта'),
      ),
      body: GestureDetector(
        onTap: () => {FocusScope.of(context).requestFocus(FocusNode())},
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(204, 230, 237, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      cursorColor: const Color.fromRGBO(112, 112, 112, 1),
                      inputFormatters: [cardMaskFormatter],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        label: Text(
                          'Номер карты',
                          style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 1)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: dateController,
                            inputFormatters: [dateMaskFormatter],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                              label: Text(
                                'Срок действия',
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                        Expanded(
                          child: TextField(
                            controller: cvvController,
                            inputFormatters: [cvvMaskFormatter],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                              label: Text(
                                'CVV',
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed("/register");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color.fromRGBO(195, 195, 195, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "Добавить карту",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "GT-Eesti-Pro-Display",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
