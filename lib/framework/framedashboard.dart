import 'package:flutter/material.dart';
import 'package:testlogin/dashboard.dart';

class FrameMainDashBoard extends StatefulWidget {
  const FrameMainDashBoard({Key? key}) : super(key: key);

  @override
  State<FrameMainDashBoard> createState() => _FrameMainDashBoardState();
}

class _FrameMainDashBoardState extends State<FrameMainDashBoard>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 74,
              color: Colors.white,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 130,
                        height: 30,
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const DashBoard();
                          }),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'Hotline phản hồi',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffBCBCBC)),
                            ),
                            Text(
                              '0913 714 479',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          color: Color(0xffDDDDDD),
                          endIndent: 7,
                        ),
                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          icon: Image.asset('assets/images/iconmenu.png'),
                          splashRadius: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
