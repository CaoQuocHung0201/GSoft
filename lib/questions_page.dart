import 'package:flutter/material.dart';
import 'framework/framemain.dart';
import 'framework/frameworkbottom.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPage();
}

class _QuestionsPage extends State<QuestionsPage> {
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
                    height: 550,
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
                              height: 30,
                              child: const Text(
                                'Câu hỏi thường gặp',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff696969),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 480,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: Color(0xff009DE5)
                                              ),
                                              child: const Text(
                                                '1',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Hướng dẫn share quyền Google Analytics",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Color(0xff11D0A2)
                                              ),
                                              child: const Text(
                                                '2',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Hướng dẫn share quyền Google Webmaster Tools",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Color(0xffFFB13D)
                                              ),
                                              child: const Text(
                                                '3',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Hướng dãn kiểm tra bài viết copy",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Color(0xffFF7474)
                                              ),
                                              child: const Text(
                                                '4',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Bài viết chuẩn SEO cho các từ khóa bán hàng",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Color(0xff009DE5)
                                              ),
                                              child: const Text(
                                                '5',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Bài viết chuẩn SEO cho các từ khóa dịch vụ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 70.0,
                                              height: 70.0,
                                              //color: Color(0xff009DE5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: Color(0xff11D0A2)
                                              ),
                                              child: const Text(
                                                '6',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: const Text(
                                              "Hướng dẫn kiểm tra thứ hạng từ khóa trên Rankchecker",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //height: double.infinity,
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
}
