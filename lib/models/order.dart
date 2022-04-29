import '../constants/app_constants.dart';

class Order {
  int id;
  int userId;
  int addressId;
  String itemUrl;
  double paymentAmount;
  String? note;
  DateTime purchaseDate;
  DateTime updatedDate;
  OrderStatus status;
  bool deleted;
  Retailer retailer;
  String? cancelReason;
  String? trackingUrl;
  String? trackingNumber;
  String? purchaseScreenshotUrl;

  Order({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.itemUrl,
    required this.paymentAmount,
    required this.retailer,
    this.note,
    required this.purchaseDate,
    required this.updatedDate,
    this.status = OrderStatus.AWAITING_VERIFICATION,
    this.deleted = false,
  });
}
