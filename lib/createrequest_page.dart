import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:testlogin/main.dart';
import 'package:testlogin/subdashboard/navbar.dart';
import 'dashboard.dart';
import 'framework/framedashboard.dart';
import 'framework/frameworkbottom.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:path/path.dart';

Future<Request> createRequest(String userName, String depID,int typeService, String requestType, String service, String title, String content) async {
  String url ='https://portal.ggroup.vn:9070///api/SendRequest/Send/?role=${DashBoardState.role}';
  String token='${RootPageState.token}';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${token}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<dynamic, dynamic>{
      "request": {
        "userName": userName,
        "depID": depID,
        "typeService": typeService,
        "requestType": requestType,
        "service": service,
        "title": title,
        "content": content
      },
      "fileUpload": []
    }),
  );
  if (response.statusCode == 201) {
    return Request.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create request.');
  }
}
Future<Request> createRequestFile(String userName, String depID,int typeService, String requestType, String service, String title, String content, String fileName) async {
  String url ='https://portal.ggroup.vn:9070///api/SendRequest/Send/?role=${DashBoardState.role}';
  String token='${RootPageState.token}';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${token}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<dynamic, dynamic>{
      "request": {
        "userName": userName,
        "depID": depID,
        "typeService": typeService,
        "requestType": requestType,
        "service": service,
        "title": title,
        "content": content
      },
      "fileUpload": [
        {
          "fileName": fileName,
          "createDT": "2022-07-29T08:42:38.380Z"
        }
      ]
    }),
  );
  if (response.statusCode == 201) {
    return Request.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create request.');
  }
}

class Request {
  final String title;

  const Request({required this.title});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      title: json['title'],
    );
  }
}
class CreaterequestPage extends StatefulWidget {
  const CreaterequestPage({Key? key}) : super(key: key);

  @override
  State<CreaterequestPage> createState() => CreaterequestPageState();
}

class CreaterequestPageState extends State<CreaterequestPage> {
  List<String> websites = DashBoardState.website.map((web) => web.websiteUrl).toList();
  List<String> idwebsites = DashBoardState.website.map((web) => web.id.toString()).toList();
  bool displayButton = false;
  String userName=RootPageState.username;
  String depID='';
  int typeService=0;
  String requestType='';
  String service='';
  String title='';
  String content='';
  String filename='';
  double size=0;
  String filenameupload='';
  String createDT='2022-07-29T08:42:38.380Z';
  var txtTitle=TextEditingController();
  var txtContent=TextEditingController();
  File? _imageFile;
  Future<Request>? _futureRequest;
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
                height: 1200,
                child: Column(
                  children: [
                    Container(
                      //height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.fromLTRB(16, 20, 16, 5),
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tạo yêu cầu',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Dịch vụ',
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                      fontSize: 15)),
                              isExpanded: true,
                              hint: const Text(
                                '--Chọn dịch vụ--',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff696969)),
                              ),
                              isDense: true,
                              icon: Icon(Icons.arrow_drop_down_circle),
                              items: RootPageState.dichvu.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xff696969)),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  RootPageState.dichvuhientai = newValue.toString();
                                });
                                int index=RootPageState.dichvu.indexOf(newValue.toString());
                                if(index==0){
                                  setState((){
                                    service='HTDME';
                                  });
                                }
                                if(index==1){
                                  setState((){
                                    service='TKW';
                                  });
                                }
                                if(index==2){
                                  setState((){
                                    service='PTPM';
                                  });
                                }
                                if(index==3){
                                  setState((){
                                    service='ITOS';
                                  });
                                }
                                //print('$service');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Website',
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                      fontSize: 15)),
                              isExpanded: true,
                              hint: const Text(
                                '--Chọn website--',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff696969)),
                              ),
                              isDense: true,
                              icon: Icon(Icons.arrow_drop_down_circle),
                              items: DashBoardState.website.map((data) {
                                return DropdownMenuItem(
                                    value: data.id.toString(),
                                    child: Text(
                                      data.websiteUrl.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xff696969)),
                                    ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  DashBoardState.websitehientai = newValue.toString();
                                  typeService=int.parse(DashBoardState.websitehientai);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Loại yêu cầu',
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                      fontSize: 15)),
                              isExpanded: true,
                              hint: const Text(
                                '--Chọn loại yêu cầu--',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff696969)),
                              ),
                              isDense: true,
                              icon: Icon(Icons.arrow_drop_down_circle),
                              items: RootPageState.yeucau.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xff696969)),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  RootPageState.yeucauhientai = newValue.toString();
                                });
                                int index=RootPageState.yeucau.indexOf(newValue.toString());
                                if(index==0){
                                  setState((){
                                    requestType='THDA';
                                  });
                                }
                                if(index==1){
                                  setState((){
                                    requestType='TP';
                                  });
                                }
                                if(index==2){
                                  setState((){
                                    requestType='PHI';
                                  });
                                }
                                if(index==3){
                                  setState((){
                                    requestType='TTGT';
                                  });
                                }
                                if(index==4){
                                  setState((){
                                    requestType='Others';
                                  });
                                }
                                if(index==5){
                                  setState((){
                                    requestType='GTKH';
                                  });
                                }
                                print('$requestType');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDADADA), width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDADADA), width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Phòng ban',
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                    fontSize: 15),
                              ),
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
                              icon: Icon(Icons.arrow_drop_down_circle),
                              items: RootPageState.phongban.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xff696969)),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  RootPageState.phongbanhientai = newValue.toString();
                                });
                                int index=RootPageState.phongban.indexOf(newValue.toString());
                                if(index==0){
                                  setState((){
                                    depID='PBKTV';
                                  });
                                }
                                if(index==1){
                                  setState((){
                                    depID='PBCSKH';
                                  });
                                }
                                if(index==2){
                                  setState((){
                                    depID='PBKT';
                                  });
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: txtTitle,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDADADA), width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffDADADA), width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.all(23),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Nhập tiêu đề',
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                    fontSize: 15),
                              ),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Nội dung',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff696969)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextField(
                        controller: txtContent,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 10, //or null
                        decoration: const InputDecoration.collapsed(
                            hintText: "Nhập nội dung", ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Inter', fontSize: 16,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed:  () {
                            _pickFile();
                          },
                          icon: Icon(Icons.attach_file),
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all(Color(0xff009DE5)),
                            backgroundColor: MaterialStateProperty.all(Color(0xffD0EDFB)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                //side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          label: const Text(
                            'Tải tệp tin đính kèm',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        'Tên file đã chọn: $filename',
                        style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff696969)),
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        'Dung lượng: $size MB',
                        style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff696969)),
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Tổng files đính kèm tối đa 25MB',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic ,
                            color: Color(0xff696969)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:  () {
                            title=txtTitle.text;content=txtContent.text;
                            if(userName != '' && depID != '' && typeService != 0 && requestType != '' && service != '' && title != '' && content != '' && filename == ''){
                              _futureRequest=createRequest(userName, depID, typeService, requestType, service, title, content);
                              showSuccess();
                            }
                            else if(userName != '' && depID != '' && typeService != 0 && requestType != '' && service != '' && title != '' && content != '' && filename != ''){
                              _futureRequest=createRequestFile(userName, depID, typeService, requestType, service, title, content, filenameupload);
                              showSuccess();
                            }else {
                              showAlert();
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Color(0xffFF7474)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                //side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Tạo yêu cầu',
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
              ),
            ),
          ),
          const FrameworkBottom()
        ],
      ),
    );
  }
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    _imageFile = File(result.files.first.path!);
    setState((){
      filename=result.files.first.name;
    });
    size=(result.files.first.size) / 1048576;
    size=(size * 100).round() / 100.0;
    if (size > 25){
      showError();
      return;
    }else{
      Upload(_imageFile!);
    }
  }

  Upload(File imageFile) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy_MM_dd_HH_mm_ss_').format(now);
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('https://portal.ggroup.vn:9070///api/Upload/UploadFileRequest');
    //var uri = Uri.parse('http://httpbin.org/post');
    setState((){
      filenameupload = '$formattedDate${basename(imageFile.path)}';
      print('${filenameupload}');
    });
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length, filename: filenameupload);
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
void showAlert(){
    showDialog(
      context: this.context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Phải nhập đầy đủ thông tin!!!"),
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
  void showSuccess(){
    showDialog(
      context: this.context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Tạo thành công!!!"),
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
  void showError(){
    showDialog(
      context: this.context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Tập tin vượt quá 25MB!!!"),
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
}

