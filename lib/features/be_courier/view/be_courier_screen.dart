import 'package:delivery_kam/features/be_courier/bloc/be_courier_bloc.dart';
import 'package:delivery_kam/features/main/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeCourierScreen extends StatelessWidget {
  const BeCourierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final beCourierBloc = BeCourierBloc();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Стать курьером'),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16)
            .copyWith(bottom: 25)
            .copyWith(top: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocBuilder<BeCourierBloc, BeCourierState>(
          bloc: beCourierBloc,
          builder: (context, state) {
            if (state is BeCourierInitial) {
              return GradientButton(
                  onPressed: () {
                    beCourierBloc.add(BeCourierTapped());
                  },
                  label: 'Хочу стать курьером');
            } else {
              return GradientButton(
                  disabled: true,
                  onPressed: () {
                    beCourierBloc.add(BeCourierTapped());
                  },
                  label: 'Хочу стать курьером');
            }
          },
        ),
      ),
      body: BlocListener<BeCourierBloc, BeCourierState>(
        bloc: beCourierBloc,
        listener: (context, state) {
          if (state is BeCourierSuccess) {
            showModalBottomSheet(
                context: context,
                elevation: 0,
                builder: (BuildContext context) {
                  return Wrap(children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40).copyWith(bottom: 60),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(204, 230, 237, 1),
                        borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30))
                            .copyWith(
                          topRight: const Radius.circular(30),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Спасибо за заявку',
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
                });
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 250),
              child: Text(
                'Хочешь стать частью нашей команды?\n\nОставь заявку и мы с тобой свяжемся',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
