import 'package:delivery_kam/models/address_api.dart';
import 'package:delivery_kam/models/courier.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Order {
  String id;
  List<AddressPost> address;
  bool byCar;
  bool toDoor;
  String cargoItem;
  double cargoValue;
  double cargoMass;
  String comment;
  bool fragileCargo;
  bool thermalBag;
  bool bulkyCargo;
  bool transportDepartureRegistration;
  bool postOfficeCorrespondence;
  Courier? courier;
  int? price;

  Order({
    this.id = '',
    required this.address,
    this.byCar = false,
    this.toDoor = false,
    this.cargoItem = '',
    this.cargoValue = 0,
    this.cargoMass = 0,
    this.comment = '',
    this.fragileCargo = false,
    this.thermalBag = false,
    this.bulkyCargo = false,
    this.transportDepartureRegistration = false,
    this.postOfficeCorrespondence = false,
    this.courier,
    this.price
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> addressJson = [];
    for (var address in address) {
      addressJson.add(address.toJson());
    }
    return {
      'id': id,
      'address': address,
      'by_car': byCar,
      'to_door': toDoor,
      'cargo_item': cargoItem,
      'cargo_value': cargoValue,
      'cargo_mass': cargoMass,
      'comment': comment,
      'fragile_cargo': fragileCargo,
      'thermal_bag': thermalBag,
      'bulky_cargo': bulkyCargo,
      'transport_departure_registration': transportDepartureRegistration,
      'post_office_correspondence': postOfficeCorrespondence,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    List<AddressPost> addressess = [];
    if (json['addresses'] != null) {
      json['addresses'].forEach((addressPostJson) =>
          {addressess.add(AddressPost.fromJson(addressPostJson))});
    }

    return Order(
      id: json['id'],
      address: addressess,
      byCar: json['by_car'],
      toDoor: json['to_door'],
      cargoItem: json['cargo_item'],
      cargoValue: json['cargo_value'] ?? 0,
      cargoMass: json['cargo_mass'] ?? 0,
      comment: json['comment'],
      fragileCargo: json['fragile_cargo'],
      thermalBag: json['thermal_bag'],
      bulkyCargo: json['bulky_cargo'],
      transportDepartureRegistration: json['transport_departure_registration'],
      postOfficeCorrespondence: json['post_office_correspondence'],
      price: json['price'],
      courier: Courier.fromJson(
        json['courier'],
      ),
    );
  }
}

class OrderRoute {
  final String geometry;

  OrderRoute({required this.geometry});

  factory OrderRoute.fromJson(Map<String, dynamic> json) {
    return OrderRoute(geometry: json['geometry']);
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

enum OrderCancelReason { deliveryTime, changePlans, byCourier, expensive }

extension OrderCancelReasonExtension on OrderCancelReason {
  String get value {
    switch (this) {
      case OrderCancelReason.deliveryTime:
        return 'слишком долго ждать';
      case OrderCancelReason.changePlans:
        return 'изменились планы';
      case OrderCancelReason.byCourier:
        return 'курьер попросил отменить';
      case OrderCancelReason.expensive:
        return 'не устроила цена доставки';
    }
  }
}
