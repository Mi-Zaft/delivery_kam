class Order {
  String fromWhere;
  String toWhere;
  bool byCar = false;

  Order({required this.fromWhere, required this.toWhere, byCar});
}

class OrderHistoryItem {
  String id;
  String date;

  OrderHistoryItem({required this.id, required this.date});
}
