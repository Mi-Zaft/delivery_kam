import 'package:delivery_kam/features/main/bloc/delivery_main_bloc.dart';
import 'package:delivery_kam/models/user.dart';
import 'package:flutter/material.dart';

class DeliveryMainDrawer extends StatelessWidget {
  const DeliveryMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveryMainBloc = DeliveryMainBloc();
    return Drawer(
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
              SizedBox(
                width: 150,
                child: Text(
                  User().name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
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
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
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
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            child: ListTile(
              onTap: () async => {
                deliveryMainBloc.add(
                  LoadingExitFromAccount(),
                ),
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false)
              },
              leading: Image.asset(
                'assets/images/main/exit.png',
              ),
              title: const Text(
                'Выйти из аккаунта',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
