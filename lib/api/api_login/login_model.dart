class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["access_token"] != null ? json["access_token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}
class LoginRequestModel {
  String? email;
  String? password;
  String? grant;

  LoginRequestModel({
    this.email,
    this.password,
    this.grant
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': email?.trim(),
      'password': password?.trim(),
      'grant_type': 'password'
    };
    return map;
  }
}
