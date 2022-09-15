
import 'package:flutter/material.dart';
import 'package:testlogin/dashboard.dart';
import 'package:testlogin/fillrequest_page.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/profile_page.dart';
import 'package:testlogin/questions_page.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(15),
      color: Color(0xffe5e5e5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward),
            splashRadius: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height- 132,
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  child: const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.home_outlined,
                        color: Colors.cyan,
                      ),
                      title: Text(
                        'Trang chú',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const DashBoard();
                      }),
                    );
                  },
                ),
                GestureDetector(
                  child: const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.person_outline,
                        color: Colors.cyan,
                      ),
                      title: Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const ProfilePage();
                      }),
                    );
                  },
                ),
                GestureDetector(
                  child: const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.request_page_outlined,
                        color: Colors.cyan,
                      ),
                      title: Text(
                        'Danh sách yêu cầu',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const FillrequestPage();
                      }),
                    );
                  },
                ),
                GestureDetector(
                  child: const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.question_mark_outlined,
                        color: Colors.cyan,
                      ),
                      title: Text(
                        'Câu hỏi thường gặp',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(top: 10),
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RootPage(),
                  ),
                  (Route route) => false,
                );
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Color(0xffA1DDFF)),
                  ),
                ),
              ),
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                    color: Color(0xff696969),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
