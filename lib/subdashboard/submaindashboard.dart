import 'package:flutter/material.dart';
import 'package:testlogin/dashboard.dart';
import 'package:testlogin/fillrequest_page.dart';
import 'package:testlogin/main.dart';
import '../Object/object_request.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  String username = RootPageState.username;
  String token = RootPageState.token;
  String role=DashBoardState.role;
  final response = await http.get(
    Uri.parse(
        'https://portal.ggroup.vn:9070///api/SendRequest/GetRequestCount/?createDTSort=&fromdate=&requestType=&sPhongBan=&sRole=${role}&sSearchText=&sUserName=${username}&statusRequest=&todate='),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token}',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class SubmainDashboard extends StatefulWidget {
  const SubmainDashboard({Key? key}) : super(key: key);

  @override
  State<SubmainDashboard> createState() => _SubmainDashboardState();
}

class _SubmainDashboardState extends State<SubmainDashboard> {
  late Future<Album> futureAlbum;
  bool isApiCallProcess = false;
  late Timer _timer;
  int _start = 3;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Color(0xffe5e5e5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView(
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xff00ACFB),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xff00ACFB),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xff00ACFB),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              //'${RootPage.}',
                              '${snapshot.data!.KHYC}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'mới gửi',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='KHYC';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xff11D0A2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xff11D0A2),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xff11D0A2),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${snapshot.data!.GBDN}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'đã tiếp nhận',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='GBDN';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xffFFB13D),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xffFFB13D),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xffFFB13D),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${snapshot.data!.GBXL}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'đang xử lý',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='GBXL';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xffFF7474),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xffFF7474),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xffFF7474),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${snapshot.data!.GBTL}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'đã xử lý xong',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='GBTL';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xff00ACFB),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xff00ACFB),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xff00ACFB),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${snapshot.data!.GBYC}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'chờ phản hồi',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='GBYC';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.fromLTRB(17, 21, 0, 24),
                    decoration: const BoxDecoration(
                      color: Color(0xff11D0A2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xff11D0A2),
                              ],
                              stops: [0.0, 0.8],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 61,
                            decoration: BoxDecoration(
                                color: Color(0xff11D0A2),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              '${snapshot.data!.YCDD}',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yêu cầu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                'đã đóng',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    FillrequestPageState.trangthaifind='YCDD';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FillrequestPage();
                          }),
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          isApiCallProcess = true;
          setState(() {
            timer.cancel();
            _start = 5;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
