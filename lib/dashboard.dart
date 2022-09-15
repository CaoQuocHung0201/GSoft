import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testlogin/framework/framedashboard.dart';
import 'package:testlogin/framework/frameworkbottom.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/subdashboard/navbar.dart';
import 'package:testlogin/subdashboard/submaindashboard.dart';
import 'Object/object_profile.dart';
import 'Object/object_website.dart';
import 'createrequest_page.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  static SharedPreferences? prefs;
  static List<Website> website = [];
  static late String websitehientai;
  static String role="";
  String token = RootPageState.token;
  late Future<Profile> futureAlbum;
  Future<Profile> fetchAlbum() async {
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
  static List<Website> websiteList = <Website>[];
  Future getWebsite() {
    String url='https://portal.ggroup.vn:9070///api/Website/';
    final Uri urlparse = Uri.parse(url);
    return http.get(urlparse, headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${RootPageState.token}',
    }, );
  }
  void getWebsitesfromApi() async {
    getWebsite().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        websiteList = list.map((model) => Website.fromJson(model)).toList();
      });
    });
  }
  static void getWebsiteList() async {
    for(int i=0;i<websiteList.length;i++){
      website.add(websiteList[i]);
    }
  }
  @override
  void initState() {
    super.initState();
    getWebsitesfromApi();
    futureAlbum = fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      floatingActionButton: Align(
        alignment: Alignment(1, 0.75),
        child: FloatingActionButton(
          onPressed: () {
            if(website.length == 0){
              getWebsiteList();
            }
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const CreaterequestPage();
              }),
            );
          },
          child: Image.asset('assets/images/floatadd.png'),
        ),
      ),
      body: Column(
          children: [
            const FrameMainDashBoard(),
            Expanded(
              child: FutureBuilder<Profile>(
                  future: futureAlbum,
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return const SingleChildScrollView(
                        child: SubmainDashboard(),
                      );
                    }else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
              ),
            ),
            const FrameworkBottom()
          ],
        ),
    );
  }
}

