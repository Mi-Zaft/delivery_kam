class AddressApi {
  final String? city;
  final String street;
  final String? house;
  final int? fiasLevel;
  final String? fiasId;
  final double? latitude;
  final double? longitude;

  AddressApi({
    required this.city,
    required this.street,
    this.house,
    this.fiasLevel,
    this.fiasId,
    this.latitude,
    this.longitude,
  });

  factory AddressApi.fromJson(Map<String, dynamic> json) {
    return AddressApi(
        city: json['city'],
        street: json['street'],
        house: json['house'],
        fiasLevel: json['fias_level'],
        fiasId: json['fias_id'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}

class AddressPost {
  String fiasId;
  int priority;
  String addressRow;
  int? entrance;
  int? floor;
  int? flatOrOffice;
  String? comment;
  String? phone;
  String? intercom;
  String? name;

  AddressPost({
    required this.fiasId,
    required this.priority,
    required this.addressRow,
  });

  Map<String, dynamic> toJson() {
    return {
      'fias_id': fiasId,
      'priority': priority,
      'address_row': addressRow,
      'entrance': entrance,
      'floor': floor,
      'name': name,
      'flat_or_office': flatOrOffice,
      'comment': comment,
      'phone': phone,
      'intercom': intercom,
    };
  }

  factory AddressPost.fromJson(Map<String, dynamic> json) {
    return AddressPost(
      fiasId: json['fias_id'],
      priority: json['priority'],
      addressRow: json['address_row'] ?? 'Строка адреса',
    );
  }
}
