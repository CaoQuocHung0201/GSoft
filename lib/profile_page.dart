import 'package:flutter/material.dart';
import 'package:testlogin/Object/object_profile.dart';
import 'package:testlogin/changepass_page.dart';
import 'package:testlogin/subdashboard/navbar.dart';
import 'framework/framedashboard.dart';
import 'framework/frameworkbottom.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'main.dart';

Future<Profile> fetchAlbum() async {
  String token = RootPageState.token;
  final response = await http.get(
    Uri.parse('https://portal.ggroup.vn:9070///api/account/LocalUserInfo'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token}',
    },
  );
  if (response.statusCode == 200) {
    return Profile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureAlbum;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
  String? taxCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      body: Column(
        children: [
          FrameMainDashBoard(),
          Expanded(
            child: FutureBuilder<Profile>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.taxCode == null ){
                      taxCode = '';
                    }else {
                      taxCode=snapshot.data!.taxCode!;
                    }
                    return SingleChildScrollView(
                      child: Container(
                        color: const Color(0xffe5e5e5),
                        width: double.infinity,
                        height: 750,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
                          padding: EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Thông tin cá nhân',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Đổi mật khẩu',
                                      style: TextStyle(
                                          color: Color(0xffff7474),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Inter',
                                          fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return const ChangePassPage();
                                        }),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/avatar.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${snapshot.data!.customerName}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter',
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                                child: TextFormField(
                                  initialValue: '${snapshot.data!.userName}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon: const Icon(Icons.wallet),
                                    labelText: 'ID',
                                    labelStyle: const TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  //onChanged: (value) {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextFormField(
                                  initialValue: '${snapshot.data!.companyName}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon: const Icon(
                                        Icons.home_repair_service_outlined),
                                    labelText: 'Công ty',
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextFormField(
                                  initialValue: '${snapshot.data!.email}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon: const Icon(Icons.mail_outline),
                                    labelText: 'Mail',
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextFormField(
                                  initialValue: '${snapshot.data!.address}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon:
                                        const Icon(Icons.location_on_outlined),
                                    labelText: 'Địa chỉ',
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextFormField(
                                  //initialValue: '${snapshot.data!.taxCode}',
                                  initialValue: '${taxCode}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon: const Icon(Icons.numbers),
                                    labelText: 'MST',
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {},
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextFormField(
                                  initialValue: '${snapshot.data!.phoneNumber}',
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff009DE5), width: 2.0),
                                    ),
                                    suffixIcon: const Icon(Icons.call),
                                    labelText: 'SĐT',
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Color(0xff696969)),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          const FrameworkBottom()
        ],
      ),
    );
  }
}
