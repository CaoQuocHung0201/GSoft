import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:testlogin/dashboard.dart';
import 'package:testlogin/subdashboard/navbar.dart';
import 'framework/framedashboard.dart';
import 'framework/frameworkbottom.dart';
import 'createrequest_page.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'main.dart';

class FillrequestPage extends StatefulWidget {
  const FillrequestPage({Key? key}) : super(key: key);

  @override
  State<FillrequestPage> createState() => FillrequestPageState();
}

class FillrequestPageState extends State<FillrequestPage> {
  List<String> phongban = ['Tất cả','Phòng kỹ thuật','Phòng chăm sóc khách hàng','Phòng kế toán'];
  late String phongbanhientai;
  List<String> yeucau = ['Tất cả','Thực hiện dự án','Than phiền','Phí','Thủ tục giấy tờ','Khác','Giới thiệu khách hàng'];
  late String yeucauhientai;
  List<String> ngaytao = ['Tất cả','Những vấn đề được tạo trong 3 ngày','Những vấn đề được tạo trong 7 ngày','Những vấn đề được tạo quá 7 ngày'];
  late String ngaytaohientai;
  List<String> trangthai = ['Tất cả','Mới gửi','Đã tiếp  nhận','Đang xử lý','Xử lý xong','GSOFT yêu cầu phản hồi','Đã đóng'];
  late String trangthaihientai;
  var txt = TextEditingController();
  var txt2 = TextEditingController();
  String username=RootPageState.username;
  String token=RootPageState.token;
  String role=DashBoardState.role;
  String searchId='';
  String dateStart='';
  String dateEnd='';

  String phongbanfind='';
  String yeucaufind='';
  String ngaytaofind='';
  static String trangthaifind='';

  Future<List<dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://portal.ggroup.vn:9070///api/SendRequest/Search/?createDTSort=$ngaytaofind&fromdate=$dateStart&id=$username&isFeedback=false&page=1&pageSize=10&requestType=$yeucaufind&role=$role&sPhongBan=$phongbanfind&searchtext=$searchId&sortBy=createDT&sortDirection=desc&status=&statusRequest=$trangthaifind&todate=$dateEnd'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token}',
      },
    );
    return json.decode(response.body)['content'];
  }

  String title(dynamic title) {
    return title['title'];
  }

  String website(dynamic website) {
    return website['typeName'];
  }

  String department(dynamic department) {
    return department['deptName'];
  }

  int id(dynamic id) {
    return id['id'];
  }

  String request(dynamic request) {
    return request['requestType'];
  }

  String status(dynamic status) {
    return status['statusName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      body: Column(
        children: [
          FrameMainDashBoard(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xffe5e5e5),
                width: double.infinity,
                //height: 830,
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
                  padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tạo yêu cầu',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Color(0xffFF7474),
                            onPressed: () {
                              if(DashBoardState.website.length == 0){
                                DashBoardState.getWebsiteList();
                              }
                              DashBoardState.getWebsiteList();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const CreaterequestPage();
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 260,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff009DE5), width: 2.0),
                                ),
                                labelText: 'Tìm theo mã yêu cầu...',
                                labelStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xff696969)),
                              ),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              onChanged: (value) {
                                setState((){
                                  searchId=value;
                                });
                              },
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              showModalBottomSheet<dynamic>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  // <-- SEE HERE
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(30),
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Lọc yêu cầu',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 20, 5, 10),
                                              child: TextField(
                                                controller: txt,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xff009DE5),
                                                            width: 2.0),
                                                  ),
                                                  suffixIcon: const Icon(
                                                      Icons.date_range),
                                                  labelText: 'Từ ngày',
                                                  labelStyle: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff696969)),
                                                ),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                onChanged: (value) {},
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          //context of current state
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101));
                                                  if (pickedDate != null) {
                                                    String formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(pickedDate);
                                                    txt.text = formattedDate;
                                                    setState((){
                                                      String date=formattedDate.substring(0,2);
                                                      String month=formattedDate.substring(3,5);
                                                      String year=formattedDate.substring(6,10);
                                                      dateStart='$year%2F$month%2F$date';
                                                    });
                                                  } else {
                                                    print(
                                                        "Date is not selected");
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 20, 5, 10),
                                              child: TextField(
                                                controller: txt2,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xff009DE5),
                                                            width: 2.0),
                                                  ),
                                                  suffixIcon: const Icon(
                                                      Icons.date_range),
                                                  labelText: 'Đến ngày',
                                                  labelStyle: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff696969)),
                                                ),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                onChanged: (value) {},
                                                onTap: () async {
                                                  DateTime? pickedDate2 =
                                                      await showDatePicker(
                                                          context: context,
                                                          //context of current state
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101));
                                                  if (pickedDate2 != null) {
                                                    String formattedDate2 =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                pickedDate2);
                                                    txt2.text = formattedDate2;
                                                    String date=formattedDate2.substring(0,2);
                                                    String month=formattedDate2.substring(3,5);
                                                    String year=formattedDate2.substring(6,10);
                                                    dateEnd='$year%2F$month%2F$date';
                                                  } else {
                                                    print(
                                                        "Date is not selected");
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 00),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: 'Phòng ban',
                                                labelStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Inter',
                                                    fontSize: 15)),
                                            isExpanded: true,
                                            hint: const Text(
                                              '--Chọn phòng ban--',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xff696969)),
                                            ),
                                            isDense: true,
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle),
                                            items: phongban
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff696969)),
                                                  ));
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                phongbanhientai = newValue.toString();
                                              });
                                              int index=phongban.indexOf(newValue.toString());
                                              if(index==0){
                                                setState((){
                                                  phongbanfind='';
                                                });
                                              }
                                              if(index==1){
                                                setState((){
                                                  phongbanfind='PBKTV';
                                                });
                                              }
                                              if(index==2){
                                                setState((){
                                                  phongbanfind='PBCSKH';
                                                });
                                              }
                                              if(index==3){
                                                setState((){
                                                  phongbanfind='PBKT';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 00),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: 'Yêu cầu',
                                                labelStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Inter',
                                                    fontSize: 15)),
                                            isExpanded: true,
                                            hint: const Text(
                                              '--Chọn yêu cầu--',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xff696969)),
                                            ),
                                            isDense: true,
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle),
                                            items: yeucau
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff696969)),
                                                  ));
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                yeucauhientai =
                                                    newValue.toString();
                                              });
                                              int index=yeucau.indexOf(newValue.toString());
                                              if(index==0){
                                                setState((){
                                                  yeucaufind='';
                                                });
                                              }
                                              if(index==1){
                                                setState((){
                                                  yeucaufind='THDA';
                                                });
                                              }
                                              if(index==2){
                                                setState((){
                                                  yeucaufind='TP';
                                                });
                                              }
                                              if(index==3){
                                                setState((){
                                                  yeucaufind='PHI';
                                                });
                                              }
                                              if(index==4){
                                                setState((){
                                                  yeucaufind='TTGT';
                                                });
                                              }
                                              if(index==5){
                                                setState((){
                                                  yeucaufind='Others';
                                                });
                                              }
                                              if(index==6){
                                                setState((){
                                                  yeucaufind='GTKH';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 00),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: 'Theo ngày tạo',
                                                labelStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Inter',
                                                    fontSize: 15)),
                                            isExpanded: true,
                                            hint: const Text(
                                              '--Chọn ngày tạo--',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xff696969)),
                                            ),
                                            isDense: true,
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle),
                                            items: ngaytao
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff696969)),
                                                  ));
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                ngaytaohientai =
                                                    newValue.toString();
                                              });
                                              int index=ngaytao.indexOf(newValue.toString());
                                              if(index==0){
                                                setState((){
                                                  ngaytaofind='';
                                                });
                                              }
                                              if(index==1){
                                                setState((){
                                                  ngaytaofind='3';
                                                });
                                              }
                                              if(index==2){
                                                setState((){
                                                  ngaytaofind='7';
                                                });
                                              }
                                              if(index==3){
                                                setState((){
                                                  ngaytaofind='%3E7';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 00),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffDADADA),
                                                      width: 2),
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: 'Theo trạng thái',
                                                labelStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Inter',
                                                    fontSize: 15)),
                                            isExpanded: true,
                                            hint: const Text(
                                              '--Chọn trạng thái--',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xff696969)),
                                            ),
                                            isDense: true,
                                            icon: Icon(
                                                Icons.arrow_drop_down_circle),
                                            items: trangthai
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 14,
                                                        color:
                                                        Color(0xff696969)),
                                                  ));
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                trangthaihientai =
                                                    newValue.toString();
                                              });
                                              int index=trangthai.indexOf(newValue.toString());
                                              if(index==0){
                                                setState((){
                                                  trangthaifind='';
                                                });
                                              }
                                              if(index==1){
                                                setState((){
                                                  trangthaifind='KHYC';
                                                });
                                              }
                                              if(index==2){
                                                setState((){
                                                  trangthaifind='GBDN';
                                                });
                                              }
                                              if(index==3){
                                                setState((){
                                                  trangthaifind='GBXL';
                                                });
                                              }
                                              if(index==4){
                                                setState((){
                                                  trangthaifind='GBTL';
                                                });
                                              }
                                              if(index==5){
                                                setState((){
                                                  trangthaifind='GBYC';
                                                });
                                              }
                                              if(index==6){
                                                setState((){
                                                  trangthaifind='YCDD';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 12, 0, 00),
                                          child: SizedBox(
                                            height: 40,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xffFF7474)),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    //side: BorderSide(color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'Xem',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.filter_list_alt),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xff009DE5)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            label: const Text(
                              'Lọc',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: MediaQuery.of(context).size.height - 10,
                        width: double.infinity,
                        child: FutureBuilder<List<dynamic>>(
                          future: fetchData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  padding: EdgeInsets.all(8),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: Colors.white,
                                      shadowColor: Colors.blueGrey,
                                      elevation: 3,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Container(
                                        //color: Colors.green,
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              //mainAxisAlignment: MainAxisAlignment.,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  <Widget>[
                                                Container(
                                                  width: 220,
                                                  child: Text.rich(
                                                    //overflow: TextOverflow.ellipsis,
                                                    TextSpan(
                                                      children: <InlineSpan>[
                                                        const WidgetSpan(
                                                            child: Icon(
                                                          Icons
                                                              .request_page_outlined,
                                                          size: 14,
                                                          color:
                                                              Color(0xff696969),
                                                        )),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 20,
                                                        )),
                                                        TextSpan(text: '${title(snapshot.data[index])}'),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color(0xff454343)),
                                                  ),
                                                ),
                                                Container(
                                                  width: 220,
                                                  child: Text.rich(
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    //overflow: TextOverflow.ellipsis,
                                                    TextSpan(
                                                      children: <InlineSpan>[
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          child: Icon(
                                                            Icons.web,
                                                            size: 14,
                                                            color:
                                                                Color(0xff696969),
                                                          ),
                                                        )),
                                                        const WidgetSpan(
                                                            child: SizedBox(
                                                          width: 20,
                                                        )),
                                                        TextSpan(text: 'Website: ${website(snapshot.data[index])}'),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 9,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color(0xff696969)),
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    children: <InlineSpan>[
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        child: Icon(
                                                          Icons.source_outlined,
                                                          size: 14,
                                                          color:
                                                              Color(0xff696969),
                                                        ),
                                                      )),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 20,
                                                      )),
                                                      TextSpan(text: '${department(snapshot.data[index])}'),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff696969)),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    children: <InlineSpan>[
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        child: Icon(
                                                          Icons.credit_card,
                                                          size: 14,
                                                          color:
                                                              Color(0xff696969),
                                                        ),
                                                      )),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 20,
                                                      )),
                                                      TextSpan(text: 'ID: ${id(snapshot.data[index])}'),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff696969)),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    children: <InlineSpan>[
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        child: Icon(
                                                          Icons
                                                              .edit_calendar_outlined,
                                                          size: 14,
                                                          color:
                                                              Color(0xff696969),
                                                        ),
                                                      )),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 20,
                                                      )),
                                                      TextSpan(
                                                          text:
                                                              'Yêu cầu: ${request(snapshot.data[index])}'),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff696969)),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              //color: Colors.cyan,
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Trạng thái',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff00ACFB),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Inter'),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(vertical: 5),
                                                      width: 55,
                                                      height: 55,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                100),
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color(0xffFF7474),
                                                            Colors.white,
                                                          ],
                                                          stops: [0.0, 0.8],
                                                          begin: FractionalOffset
                                                              .bottomLeft,
                                                          end: FractionalOffset
                                                              .topRight,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets.all(4),
                                                        alignment:
                                                            Alignment.center,
                                                        width: 52,
                                                        height: 52,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        child: Text(
                                                          //overflow: TextOverflow.ellipsis,
                                                          status(snapshot.data[index]),
                                                          style: const TextStyle(
                                                              fontFamily: 'Inter',
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize: 8,
                                                              color: Color(
                                                                  0xffFF7474)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const FrameworkBottom()
        ],
      ),
    );
  }
}
