import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/questions_page.dart';
import 'package:testlogin/verificationcodes_page.dart';
import 'framework/framemain.dart';
import 'framework/frameworkbottom.dart';

class NewpassPage extends StatefulWidget {
  const NewpassPage({Key? key}) : super(key: key);

  @override
  State<NewpassPage> createState() => _NewpassPage();
}

class _NewpassPage extends State<NewpassPage> {
  bool displayPass = true;
  bool isPass = false;
  bool isrePass = false;
  bool displayButton = false;
  String newPass = '';
  String renewPass = '';

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
                    height: 500,
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
                                'Đặt mật khẩu mới',
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
                              height: 35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Mật khẩu mới',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00ACFB),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isPass,
                                    child: Column(
                                      children: const [
                                        Text(
                                          'Mật khẩu ít nhất có 6 ký tự',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            color: Color(0xffFF0000),
                                          ),
                                        ),
                                        Text(
                                          'chữ hoa, chữ thường và số',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            color: Color(0xffFF0000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextField(
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
                                hintText: 'Nhập mật khẩu mới của bạn',
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
                                  newPass = value;
                                  if (!validateStructure(newPass))
                                    isPass = true;
                                  else
                                    isPass = false;
                                });
                              },
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              width: 324,
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Nhập lại',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00ACFB),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isrePass,
                                    child: const Text(
                                      'Chưa khớp với mật khẩu mới',
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
                              obscureText: displayPass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff009DE5), width: 1.0),
                                ),
                                hintText: 'Nhập lại mật khẩu mới của bạn',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff696969),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: isrePass == false
                                          ? Color(0xff009DE5)
                                          : Color(0xffFF0000),
                                      width: 2.0),
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
                                  renewPass = value;
                                  if ("${newPass}" == "${renewPass}") {
                                    isrePass = false;
                                    displayButton = true;
                                  } else {
                                    isrePass = true;
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
                                onPressed: displayButton ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const RootPage();
                                    }),
                                  );
                                }: null,
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                      (displayButton == true ? Color(0xffFF7474) : Color(0xffFFB6C1))),
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
                              height: 135,
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

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
