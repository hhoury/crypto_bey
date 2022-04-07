class Address {
  String id;
  String receiver;
  String address;
  bool deleted;
  Address(
      {required this.id,
      required this.receiver,
      required this.address,
      this.deleted = false});
}
