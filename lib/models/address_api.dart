class AddressApi {
  final String street;
  final String? house;

  AddressApi({required this.street, this.house});

  factory AddressApi.fromJson(Map<String, dynamic> json) {
    return AddressApi(
      street: json['street'],
      house: json['house'],
    );
  }
}
