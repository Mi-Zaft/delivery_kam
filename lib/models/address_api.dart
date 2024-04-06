class AddressApi {
  final String street;
  final String? house;
  final int? fiasLevel;
  final String? fiasId;

  AddressApi({required this.street, this.house, this.fiasLevel, this.fiasId});

  factory AddressApi.fromJson(Map<String, dynamic> json) {
    return AddressApi(
      street: json['street'],
      house: json['house'],
      fiasLevel: json['fiasLevel'],
      fiasId: json['fiasId'],
    );
  }
}
