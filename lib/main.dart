import 'package:flutter/material.dart';
import 'package:testlogin/ProgressHUD.dart';
import 'package:testlogin/dashboard.dart';
import 'package:testlogin/forgotpass_page.dart';
import 'package:testlogin/framework/framemain.dart';
import 'package:testlogin/framework/frameworkbottom.dart';
import 'package:testlogin/questions_page.dart';
import 'api/api_login/api_service.dart';
import 'api/api_login/login_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoBranding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  static String username = '';
  static String token = "";
  bool displayPass = true;
  bool displayisEmail = false;
  String pass = '';
  bool isButtonDisable = false;
  bool isPass = false;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModel loginRequestModel;
  String? userremember;
  String? passremember;
  var controllerUser = TextEditingController();
  var controllerPass = TextEditingController();

  //final storage = FlutterSecureStorage();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static List<String> dichvu = [
    'Dịch vụ hosting /domain/email',
    'Dịch vụ thiết kế website',
    'Dịch vụ phát triển phần mềm',
    'Dịch vụ IT Onsite'
  ];
  static late String dichvuhientai;
  static List<String> phongban = [
    'Phòng kỹ thuật',
    'Phòng chăm sóc khách hàng',
    'Phòng kế toán'
  ];
  static late String phongbanhientai;
  static List<String> yeucau = [
    'Thực hiện dự án',
    'Than phiền',
    'Phí',
    'Thủ tục giấy tờ',
    'Khác',
    'Giới thiệu khách hàng'
  ];
  static late String yeucauhientai;

  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        body: Column(
          children: [
            const FrameworkMain(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                      width: double.infinity,
                      height: 490,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 56,
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff696969),
                                  ),
                                ),
                              ),
                              Container(
                                width: 324,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tài khoản',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff00ACFB),
                                      ),
                                    ),
                                    Visibility(
                                      visible: displayisEmail,
                                      child: const Text(
                                        'Email không hợp lệ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          color: Color(0xffFF0000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: controllerUser,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff009DE5), width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff009DE5), width: 2.0),
                                  ),
                                  hintText: 'Nhập tài khoản',
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff696969),
                                  ),
                                  suffixIcon: const Icon(Icons.account_circle),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                    if (username.length > 0 &&
                                        pass.length > 0) {
                                      isButtonDisable = true;
                                    } else
                                      isButtonDisable = false;
                                  });
                                },
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: 324,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Mật khẩu',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff00ACFB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: controllerPass,
                                obscureText: displayPass,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff009DE5), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: isPass == false
                                            ? Color(0xff009DE5)
                                            : Color(0xffFF0000),
                                        width: 2.0),
                                  ),
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff696969),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon((displayPass == true)
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        displayPass = !displayPass;
                                      });
                                    },
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                onChanged: (value) {
                                  setState(() {
                                    pass = value;
                                    if (username.length > 0 && pass.length > 0)
                                      isButtonDisable = true;
                                    else
                                      isButtonDisable = false;
                                  });
                                },
                              ),
                              Visibility(
                                visible: isPass,
                                child: Column(
                                  children: const [
                                    Text(
                                      'Tài khoản hoặc mật khẩu không đúng.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        color: Color(0xffFF0000),
                                      ),
                                    ),
                                    Text(
                                      'Vui lòng kiểm tra và thử lại',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        color: Color(0xffFF0000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isButtonDisable
                                      ? () async {
                                          /*setState(() {
                                            isApiCallProcess = true;
                                          });
                                          loginRequestModel.email =
                                              controllerUser.text;
                                          loginRequestModel.password =
                                              controllerPass.text;
                                          print(loginRequestModel.toJson());
                                          APIService apiService = APIService();
                                          apiService.login(loginRequestModel).then((value) async {
                                            if (value != null) {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              if (value.token.length > 0) {
                                                setState((){
                                                  token=value.token;
                                                });
                                                */ /*await storage.write(key: "username", value: username);
                                                await storage.write(key: "password", value: pass);*/ /*
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (BuildContext context) {
                                                    return const DashBoard();
                                                  }),
                                                );
                                              } else {
                                                isPass=true;
                                              }
                                            }
                                          });*/
                                          /*prefs?.setString('user', username);
                                          prefs?.setString('token', token);*/
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                              return const DashBoard();
                                            }),
                                          );
                                        }
                                      : null,
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor: MaterialStateProperty.all(
                                        (isButtonDisable == true
                                            ? Color(0xffFF7474)
                                            : Color(0xffFFB6C1))),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        //side: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                //color: Colors.cyan,
                                height: 112,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Quên mật khẩu',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter',
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return const ForgotpassPage();
                                          }),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Câu hỏi thường gặp',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter',
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return const QuestionsPage();
                                          }),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const FrameworkBottom(),
          ],
        ),
      ),
    );
  }
}
