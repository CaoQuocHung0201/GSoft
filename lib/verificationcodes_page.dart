import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testlogin/forgotpass_page.dart';
import 'package:testlogin/newpass_page.dart';
import 'package:testlogin/questions_page.dart';
import 'api/api_email/api_email.dart';
import 'api/api_email/email_model.dart';
import 'framework/framemain.dart';
import 'framework/frameworkbottom.dart';
import 'main.dart';
class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePage();
}

class _CodePage extends State<CodePage> {
  late Timer _timer;
  int _start = 60;
  bool _isVisible = true;
  bool _isButtonDisable = false;
  late String code;
  bool isNumber=false;
  late EmailRequestModel emailRequestModel;

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
                                'Xác thực đối với mật khẩu',
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Mã xác thực',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00ACFB),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isNumber,
                                    child: const Text(
                                      'Phải là 6 ký tự số',
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
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff009DE5), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: isNumber ==true ? Color(0xff009DE5) : Color(0xffFF0000), width: 2.0),
                                ),
                                hintText: 'Gồm 6 chữ số',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff696969),
                                ),
                                suffixIcon: const Icon(Icons.key),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              onChanged: (value) {
                                code=value;
                                setState((){
                                  if(isNumberic(value)){
                                    isNumber=true;
                                    _isButtonDisable=true;
                                  }
                                  if(!isNumberic(value)) {
                                    _isButtonDisable=false;
                                    isNumber=false;
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
                                onPressed: _isButtonDisable ? () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return const NewpassPage();
                                          }),
                                        );
                                      }: null,
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                      (_isButtonDisable == true ? Color(0xffFF7474) : Color(0xffFFB6C1))),
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Chưa nhận được mã?',
                                        style: TextStyle(fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter',
                                          color: Color(0xff696969)
                                        ),
                                      ),
                                      Visibility(
                                        visible: !_isVisible,
                                        child: Text(' ${_start}s',
                                          style: const TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Inter',
                                              color: Color(0xff696969)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: _isVisible,
                                    child: TextButton(
                                      child: const Text(
                                        'Gửi lại',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter',
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        startTimer();
                                        showToast();
                                        emailRequestModel.email = ForgotpassPageState.txtEmail.text;
                                        APIEmail apiEmail = APIEmail();
                                        apiEmail.sendEmail(emailRequestModel);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 140,
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
                                        MaterialPageRoute(builder: (BuildContext context) {
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
                                        MaterialPageRoute(builder: (BuildContext context) {
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
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          _isVisible = !_isVisible;
          setState(() {
            timer.cancel();
            _start=5;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  bool isNumberic(String string) {
    final numericRegex =
    RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }
}
