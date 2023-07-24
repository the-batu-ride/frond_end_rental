class RegisterModel {
  String? email;
  String? firstName;
  String? lastName;
  String? adress;
  String? password;

  RegisterModel({
    this.email,
    this.firstName,
    this.lastName,
    this.adress,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'address': adress
    };
  }
}
