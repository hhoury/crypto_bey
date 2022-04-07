class Customer {
  String id;
  String fullName;
  String email;
  DateTime dateRegistered;
  bool deleted;

  Customer(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.dateRegistered,
      this.deleted = false});
}
