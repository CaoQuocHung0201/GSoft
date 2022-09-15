import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url ="https://portal.ggroup.vn:9070//token";
    final Uri urlparse = Uri.parse(url);
    final response = await http.post(urlparse, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
