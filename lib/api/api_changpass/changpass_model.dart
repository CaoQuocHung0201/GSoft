class ChangePassResponseModel {
  final String message;

  ChangePassResponseModel({required this.message});

  factory ChangePassResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePassResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class ChangepassRequestModel {
  String? confirmPassword;
  String? newPassword;
  String? oldPassword;

  ChangepassRequestModel({
    this.confirmPassword,
    this.newPassword,
    this.oldPassword,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'confirmPassword': confirmPassword?.trim(),
      'newPassword': newPassword?.trim(),
      'oldPassword': oldPassword?.trim(),
    };
    return map;
  }
}
