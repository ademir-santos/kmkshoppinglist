import 'dart:convert';

class LoginModelJson {
  
  var users;
  var password;
  var email;
  var authenticated;
  var create;
  var expiration;
  var acessToken;
  var userName;
  var userEmail;
  var message;

  LoginModelJson({
    this.users,
    this.password,
    this.email,
    this.authenticated,
    this.create,
    this.expiration,
    this.acessToken,
    this.userName,
    this.userEmail,
    this.message
  });

  factory LoginModelJson.fromJson(Map<String, dynamic> parsedJson) {
    return LoginModelJson(
      authenticated: parsedJson['authenticated'],
      create: parsedJson['create'],
      expiration: parsedJson['expiration'],
      acessToken: parsedJson['acessToken'],
      userName: parsedJson['userName'],
      userEmail: parsedJson['userEmail'],
      message: parsedJson['message']
    );
  }

  Map<String, dynamic> toJson() => {

    "users": users,

    "password": password,

    "email": email 
  };
}

LoginModelJson postFromJson(String str) {

  final jsonData = json.decode(str);

  return LoginModelJson.fromJson(jsonData);
}
