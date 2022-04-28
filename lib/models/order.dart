import '../constants/app_constants.dart';

class Order {
  String id;
  String userId;
  String addressId;
  String note;
  double paymentAmount;
  DateTime purchaseDate;
  OrderStatus status;
  bool deleted;
  Retailer retailer;
  Order(
      {required this.id,
      required this.userId,
      required this.addressId,
      required this.note,
      required this.paymentAmount,
      required this.purchaseDate,
      required this.status,
      required this.retailer,
      this.deleted = false});
}
