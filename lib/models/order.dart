import '../constants/app_constants.dart';

class Order {
  String id;
  String user;
  String receiver;
  String address;
  String note;
  double paymentAmount;
  DateTime purchaseDate;
  OrderStatus status;
  bool deleted;
  Order(
      {required this.id,
      required this.user,
      required this.receiver,
      required this.address,
      required this.note,
      required this.paymentAmount,
      required this.purchaseDate,
      required this.status,
      this.deleted = false});
}
