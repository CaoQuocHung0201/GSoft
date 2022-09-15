import 'package:flutter/material.dart';
class FrameworkBottom extends StatelessWidget {
  const FrameworkBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: const Color(0xff009DE5),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        padding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Email: support@gobranding.com.vn',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter'),
            ),
            Text(
              'Số điện thoại: 0913 713 679',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter'),
            ),
            Text(
              'Bản quyền © 2015-2016 GOBRANDING',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter'),
            ),
          ],
        ),
      ),
    );
  }
}
