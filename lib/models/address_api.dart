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
        fiasLevel: json['fiasLevel'],
        fiasId: json['fiasId'],
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
      'fiasId': fiasId,
      'priority': priority,
      'addressRow': addressRow,
      'entrance': entrance,
      'floor': floor,
      'name': name,
      'flatOrOffice': flatOrOffice,
      'comment': comment,
      'phone': phone,
      'intercom': intercom,
    };
  }

  factory AddressPost.fromJson(Map<String, dynamic> json) {
    return AddressPost(
      fiasId: json['fiasId'],
      priority: json['priority'],
      addressRow: json['addressRow'] ?? 'Строка адреса',
    );
  }
}
