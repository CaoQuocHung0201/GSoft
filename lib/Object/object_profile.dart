import 'package:testlogin/dashboard.dart';

class Profile{
  String? userName;
  String? customerName;
  String? companyName;
  String? email;
  String? address;
  String? taxCode;
  String? phoneNumber;
  String? roles;

  Profile({
    this.userName,
    this.customerName,
    this.companyName,
    this.email,
    this.address,
    this.taxCode,
    this.phoneNumber,
    this.roles
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    var rolesFromJson = json ['roles'];
    List <String> streetRole = List <String> .from (rolesFromJson);
    DashBoardState.role=streetRole[0];
    print('roles: ${DashBoardState.role}');
    return Profile(
      userName: json['userName'],
      customerName: json['customerName'],
      companyName: json['companyName'],
      email: json['email'],
      address: json['address'],
      taxCode: json['taxCode'],
      phoneNumber: json['phoneNumber'],
      roles: streetRole[0],
    );
  }
}
