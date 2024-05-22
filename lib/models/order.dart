import 'package:delivery_kam/models/address_api.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Order {
  List<AddressPost> address;
  bool byCar = false;
  bool toDoor = false;
  String cargoItem = '';
  int cargoValue = 0;
  int cargoMass = 0;
  String comment = '';
  bool fragileCargo = false;
  bool thermalBag = false;
  bool bulkyCargo = false;
  bool transportDepartureRegistration = false;
  bool postOfficeCorrespondence = false;

  Order({
    required this.address,
    byCar,
    toDoor,
    cargoItem,
    cargoValue,
    cargoMass,
    comment,
    fragileCargo,
    thermalBag,
    bulkyCargo,
    transportDepartureRegistration,
    postOfficeCorrespondence,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> addressJson = [];
    for (var address in address) {
      addressJson.add(address.toJson());
    }
    return {
      'address': address,
      'byCar': byCar,
      'toDoor': toDoor,
      'cargoItem': cargoItem,
      'cargoValue': cargoValue,
      'cargoMass': cargoMass,
      'comment': comment,
      'fragileCargo': fragileCargo,
      'thermalBag': thermalBag,
      'bulkyCargo': bulkyCargo,
      'transportDepartureRegistration': transportDepartureRegistration,
      'postOfficeCorrespondence': postOfficeCorrespondence,
    };
  }
}

class OrderRoute {
  final double latitude;
  final double longitude;

  OrderRoute({required this.latitude, required this.longitude});

  factory OrderRoute.fromJson(Map<String, dynamic> json) {
    return OrderRoute(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class OrderPrice {
  final int price;
  final List<OrderRoute> routes;

  OrderPrice({required this.price, required this.routes});

  factory OrderPrice.fromJson(Map<String, dynamic> json) {
    List<OrderRoute> routes = [];
    if (json['routes'] != null) {
      json['routes'].forEach((orderRouteJson) {
        routes.add(OrderRoute.fromJson(orderRouteJson));
      });
    }
    return OrderPrice(
      price: json['price'],
      routes: routes,
    );
  }
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
