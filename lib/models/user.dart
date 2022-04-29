class User {
  int id;
  String firstName;
  String lastName;
  String email;
  bool emailVerified;
  String phoneNumber;
  DateTime dateCreated;
  DateTime? dateUpdated;
  bool deleted;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
    required this.dateCreated,
    this.dateUpdated,
    this.deleted = false,
  });
}
