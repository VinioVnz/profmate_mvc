class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> ToJson() =>{
    'email' : email,
    'password' : password
  };

}