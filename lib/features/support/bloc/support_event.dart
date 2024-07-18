part of 'support_bloc.dart';

class SupportEvent {}

class SupportMessageSend extends SupportEvent {
  final String text;

  SupportMessageSend({required this.text});
}