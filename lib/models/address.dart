class Address {
  String id;
  String name;
  String country;
  String address;
  String unit;
  bool deleted;

  Address(
      {required this.id,
      required this.country,
      required this.name,
      required this.address,
      required this.unit,
      this.deleted = false});
}
