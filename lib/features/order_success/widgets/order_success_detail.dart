import 'package:delivery_kam/features/main/widgets/gradient_button.dart';
import 'package:delivery_kam/features/order_success/widgets/order_success_info_card.dart';
import 'package:flutter/material.dart';

class OrderSuccessDetail extends StatelessWidget {
  const OrderSuccessDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode textFieldFocus = FocusNode();
    final TextEditingController commentTextFieldController =
        TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 20).copyWith(bottom: 20),
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
      child: Column(children: [
        const Row(
          children: [
            Text(
              '13 августа 2024г. 18:59',
              style: TextStyle(fontSize: 20),
            ),
            Spacer()
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          children: [
            Text(
              'белый Hyundai Solaris',
              style: TextStyle(fontSize: 16),
            ),
            Spacer()
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          children: [
            Text(
              'цена: 240₽',
              style: TextStyle(fontSize: 16),
            ),
            Spacer()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.5,
          color: Color.fromRGBO(80, 80, 80, 1),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'Карякина 25, подъезд 1',
              style: TextStyle(fontSize: 18),
            ),
            Spacer()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'Московская 75, подъезд 3',
              style: TextStyle(fontSize: 18),
            ),
            Spacer()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1.5,
          color: Color.fromRGBO(80, 80, 80, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            OrderSuccessInfoCard(
                imagePath: 'assets/images/main/iconavatar.png',
                label: 'Александра',
                isEnable: true),
            const Spacer(),
            OrderSuccessInfoCard(
                imagePath: 'assets/images/main/iconcourier.png',
                label: 'Пеший курьер',
                isEnable: true),
            const Spacer(),
          ],
        ),
        const Divider(
          thickness: 1.5,
          color: Color.fromRGBO(80, 80, 80, 1),
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Заказ выполнен',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/order/iconOkey.png')
            ],
          ),
        ),
        Container(
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
                  .copyWith(bottom: 15),
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
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => {textFieldFocus.unfocus()},
                      focusNode: textFieldFocus,
                      controller: commentTextFieldController,
                      maxLines: null,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromRGBO(80, 80, 80, 100)),
                      cursorColor: const Color.fromRGBO(80, 80, 80, 100),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        GradientButton(
            onPressed: () {
              print('Comment send');
            },
            label: 'Отправить')
      ]),
    );
  }
}
