import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Order {
  String fromFiasId;
  String whereFiasId;
  bool byCar = false;
  bool toDoor = false;
  String floorFlatOrOfficeSender = '';
  String floorFlatOrOfficeRecipient = '';
  String senderPhone = '';
  String senderName = '';
  String recipientPhone = '';
  String recipientName = '';
  String cargoItem = '';
  int cargoValue = 0;
  int cargoMass = 0;
  String comment = '';
  String messageToRecipient = '';
  bool fragileCargo = false;
  bool thermalBag = false;
  bool bulkyCargo = false;
  bool transportDepartureRegistration = false;
  bool postOfficeCorrespondence = false;

  Order({
    required this.fromFiasId,
    required this.whereFiasId,
    byCar,
    toDoor,
    floorFlatOrOfficeSender,
    floorFlatOrOfficeRecipient,
    senderPhone,
    senderName,
    recipientPhone,
    recipientName,
    cargoItem,
    cargoValue,
    cargoMass,
    comment,
    messageToRecipient,
    fragileCargo,
    thermalBag,
    bulkyCargo,
    transportDepartureRegistration,
    postOfficeCorrespondence,
  });
}

class OrderHistoryItem {
  String id;
  int date;
  String get formattedDate {
    initializeDateFormatting('ru', null);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    String formattedDate =
        DateFormat('d MMMM yг. HH:mm', 'ru').format(dateTime);
    return formattedDate;
  }

  OrderHistoryItem({required this.id, required this.date});

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItem(
      id: json['id'],
      date: json['created_at'],
    );
  }
}
