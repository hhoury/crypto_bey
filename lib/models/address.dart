class Address {
  int id;
  String name;
  String country;
  String state;
  String city;
  String address;
  String unit;
  bool deleted;

  Address({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.name,
    required this.address,
    required this.unit,
    this.deleted = false,
  });
}
