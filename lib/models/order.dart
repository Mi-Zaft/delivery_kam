class Order {
  String fromFiasId;
  String whereFiasId;
  bool byCar = false;
  bool fragileCargo = false;
  bool thermalBag = false;
  bool bulkyCargo = false;
  bool transportDepartureRegistration = false;
  bool postOfficeCorrespondence = false;

  Order({
    required this.fromFiasId,
    required this.whereFiasId,
    byCar,
    fragileCargo,
    thermalBag,
    bulkyCargo,
    transportDepartureRegistration,
    postOfficeCorrespondence,
  });
}

class OrderHistoryItem {
  String id;
  String date;

  OrderHistoryItem({required this.id, required this.date});
}
