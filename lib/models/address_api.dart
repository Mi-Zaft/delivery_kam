class AddressApi {
  final String? city;
  final String street;
  final String? house;
  final int? fiasLevel;
  final String? fiasId;

  AddressApi({required this.city, required this.street, this.house, this.fiasLevel, this.fiasId});

  factory AddressApi.fromJson(Map<String, dynamic> json) {
    return AddressApi(
      city: json['city'],
      street: json['street'],
      house: json['house'],
      fiasLevel: json['fiasLevel'],
      fiasId: json['fiasId'],
    );
  }
}

class AddressPost {
  String fiasId;
  int priority;

  AddressPost({required this.fiasId, required this.priority});
}