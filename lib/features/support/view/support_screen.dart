import 'package:delivery_kam/features/main/widgets/gradient_button.dart';
import 'package:delivery_kam/features/support/bloc/support_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController supportMessageController =
        TextEditingController();
    final FocusNode textFieldFocus = FocusNode();
    final SupportBloc supportBloc = SupportBloc();
    return Scaffold(
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16)
              .copyWith(bottom: 25)
              .copyWith(top: 20),
          decoration: const BoxDecoration(color: Colors.white),
          child: GradientButton(
              onPressed: () {
                if (supportMessageController.text.isNotEmpty) {
                  supportBloc.add(
                      SupportMessageSend(text: supportMessageController.text));
                }
              },
              label: 'Отправить')),
      appBar: AppBar(title: const Text('Служба поддержки')),
      body: BlocListener<SupportBloc, SupportState>(
        bloc: supportBloc,
        listener: (context, state) {
          if (state is SupportMessageSendSuccess) {
            supportMessageController.clear();
            showModalBottomSheet(
              context: context,
              elevation: 0,
              builder: (BuildContext context) {
                return Wrap(children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 40).copyWith(bottom: 80),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(204, 230, 237, 1),
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(30))
                              .copyWith(
                        topRight: const Radius.circular(30),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Спасибо за обращение',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        Text(
                          'В ближайшее время мы с вами свяжемся',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ]);
              },
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: GestureDetector(
            onTap: () {
              textFieldFocus.requestFocus();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(top: 15)
                  .copyWith(bottom: 15),
              margin: const EdgeInsets.symmetric(horizontal: 25)
                  .copyWith(top: 30)
                  .copyWith(bottom: 100),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              child: Column(children: [
                Row(
                  children: [
                    const Spacer(),
                    Image.asset('assets/images/order/comment.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Обращение',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer()
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      focusNode: textFieldFocus,
                      controller: supportMessageController,
                      maxLines: null,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromRGBO(80, 80, 80, 100)),
                      cursorColor: const Color.fromRGBO(80, 80, 80, 100),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
