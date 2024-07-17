class Message {
  final String orderId;
  final String? token;
  final String? role;
  final String message;
  final String? time;

  Message({required this.orderId, required this.message, this.token, this.role, this.time});
}
