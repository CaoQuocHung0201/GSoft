class EmailResponseModel {
  final String message;

  EmailResponseModel({required this.message});

  factory EmailResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class EmailRequestModel {
  String? email;

  EmailRequestModel({
    this.email,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
    };
    return map;
  }
}
