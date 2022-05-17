class Address {
  int id;
  String name;
  String country;
  String state;
  String city;
  String addressLine1;
  String addressLine2;

  Address({
    required this.id,
    required this.country,
    this.state = '',
    this.city = '',
    required this.name,
    required this.addressLine1,
    this.addressLine2 = '',
  });
}
