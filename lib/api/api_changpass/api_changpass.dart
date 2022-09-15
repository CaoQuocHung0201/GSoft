import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testlogin/main.dart';
import 'dart:convert';
import 'changpass_model.dart';

class APIChangePass {
  Future<int> sendResponse (ChangepassRequestModel requestModel) async{
    String url ='https://portal.ggroup.vn:9070///api/Account/ChangePassword/';
    String token=RootPageState.token;
    final Uri urlparse = Uri.parse(url);
    final response = await http.post(urlparse,headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${token}',
    }, body: requestModel.toJson());
    return response.statusCode;
  }
  Future<ChangePassResponseModel> sendChangePass (ChangepassRequestModel requestModel) async {
    String url ='https://portal.ggroup.vn:9070///api/Account/ChangePassword/';
    String token=RootPageState.token;
    final Uri urlparse = Uri.parse(url);
    final response = await http.post(urlparse,headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${token}',
    }, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ChangePassResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to send pass!');
    }
  }


}
