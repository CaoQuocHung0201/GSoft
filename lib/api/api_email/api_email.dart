import 'package:http/http.dart' as http;
import 'dart:convert';
import 'email_model.dart';

class APIEmail {
  Future<EmailResponseModel> sendEmail (EmailRequestModel requestModel) async {
    String url ='https://portal.ggroup.vn:9070///api/Account/getEmailResetPass/';
    final Uri urlparse = Uri.parse(url);
    final response = await http.post(urlparse, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return EmailResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to send email!');
    }
  }
  Future<int> sendResponse (EmailRequestModel requestModel) async {
    String url ='https://portal.ggroup.vn:9070///api/Account/getEmailResetPass/';
    final Uri urlparse = Uri.parse(url);
    final response = await http.post(urlparse, body: requestModel.toJson());
    return response.statusCode;
  }

}
