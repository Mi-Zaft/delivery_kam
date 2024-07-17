class Courier {
  final String id;
  final String name;
  final String phone;
  final String type;
  final String? carModel;
  final String? carColor;
  final String? carLicensePlate;

  Courier({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
    required this.carModel,
    required this.carColor,
    required this.carLicensePlate,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      type: json['type'],
      carModel: json['carModel'],
      carColor: json['carColor'],
      carLicensePlate: json['carLicensePlate'],
    );
  }
}
