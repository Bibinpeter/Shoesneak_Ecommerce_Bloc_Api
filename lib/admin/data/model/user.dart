class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final bool blockStatus;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.blockStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      blockStatus: json['block_status'] as bool,
    );
  }

//////////////////////////////////////////////////
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'block_status': blockStatus,
    };
  }
}
