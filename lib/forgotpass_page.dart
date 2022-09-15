import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/questions_page.dart';
import 'package:testlogin/verificationcodes_page.dart';
import 'api/api_email/api_email.dart';
import 'api/api_email/email_model.dart';
import 'framework/framemain.dart';
import 'framework/frameworkbottom.dart';

class ForgotpassPage extends StatefulWidget {
  const ForgotpassPage({Key? key}) : super(key: key);

  @override
  State<ForgotpassPage> createState() => ForgotpassPageState();
}

class ForgotpassPageState extends State<ForgotpassPage> {
  bool _isVisible = true;
  String email = '';
  bool displayButton = false;
  bool displayisEmail = false;
  static var txtEmail = TextEditingController();
  late EmailRequestModel emailRequestModel;
  late Timer _timer;
  int _start = 3;

  @override
  void initState() {
    super.initState();
    emailRequestModel = EmailRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 480,
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
                                'Quên mật khẩu',
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
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00ACFB),
                                    ),
                                  ),
                                  Row(
                                    children: [
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
                                      Visibility(
                                        visible: !_isVisible,
                                        child: Text(
                                          ' ${_start}s',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Inter',
                                              color: Color(0xff696969)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              controller: txtEmail,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff009DE5), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: displayisEmail == false
                                          ? Color(0xff009DE5)
                                          : Color(0xffFF0000),
                                      width: 2.0),
                                ),
                                hintText: 'Nhập Email',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff696969),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  if (!isEmail(email)) {
                                    displayisEmail = true;
                                  } else {
                                    displayButton = true;
                                  }
                                  if (isEmail(email)) {
                                    displayisEmail = false;
                                  } else {
                                    displayButton = false;
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: displayButton == true
                                    ? () async {
                                        /*emailRequestModel.email = txtEmail.text;
                                        APIEmail apiEmail = APIEmail();
                                        int statuscode = await apiEmail.sendResponse(emailRequestModel);
                                        if(statuscode == 200){
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return const CodePage();
                                                }),
                                          );
                                          apiEmail.sendEmail(emailRequestModel);
                                        }else {
                                          showAlert();
                                        }*/
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return const CodePage();
                                          }),
                                        );
                                      }
                                    : null,
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                      (displayButton == true
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
                                  'Gửi',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              height: 240,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter',
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return const RootPage();
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
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thông báo"),
        content: Text(
            "Email sai định dạng hoặc gửi quá nhanh, cần chờ thêm thời gian!!!"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              //color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("Xác nhận"),
            ),
          ),
        ],
      ),
    );
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _isVisible = !_isVisible;
          setState(() {
            timer.cancel();
            _start = 3;
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
