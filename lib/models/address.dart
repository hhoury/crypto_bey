class Address {
  String id;
  String name;
  String country;
  String details;
  String unit;
  bool deleted;

  Address(
      {required this.id,
      required this.country,
      required this.name,
      required this.details,
      required this.unit,
      this.deleted = false});
}
