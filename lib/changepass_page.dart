import 'package:flutter/material.dart';
import 'package:testlogin/api/api_changpass/api_changpass.dart';
import 'package:testlogin/api/api_changpass/changpass_model.dart';
import 'package:testlogin/subdashboard/navbar.dart';
import 'framework/framedashboard.dart';
import 'framework/frameworkbottom.dart';
 class ChangePassPage extends StatefulWidget {
   const ChangePassPage({Key? key}) : super(key: key);
 
   @override
   State<ChangePassPage> createState() => _ChangePassPageState();
 }
 
 class _ChangePassPageState extends State<ChangePassPage> {
   bool displayPass = true;
   bool isOldPass = false;
   bool isPass = false;
   bool isrePass = false;
   String Pass='';
   String newPass = '';
   String renewPass = '';
   bool displayButton = false;
   late ChangepassRequestModel changPassRequestModel;
   var txtPass = TextEditingController();
   var txtnewPass = TextEditingController();
   var txtrenewPass = TextEditingController();
   bool check=true;
   @override
   void initState() {
     super.initState();
     changPassRequestModel = ChangepassRequestModel();
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
                 height: 730,
                 child: Container(
                   height: MediaQuery.of(context).size.height,
                   margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
                   padding: EdgeInsets.all(16),
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
                             'Đổi mật khẩu',
                             style: TextStyle(
                                 fontFamily: 'Inter',
                                 fontWeight: FontWeight.w700,
                                 fontSize: 18),
                           ),
                           TextButton(
                             child: const Text(
                               'Thông tin cá nhân',
                               style: TextStyle(
                                   color: Color(0xffff7474),
                                   fontWeight: FontWeight.w700,
                                   fontFamily: 'Inter',
                                   fontSize: 15),
                             ),
                             onPressed: () {
                               Navigator.pop(context);
                             },
                           ),
                         ],
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         width: double.infinity,
                         alignment: Alignment.centerRight,
                         child: Visibility(
                           visible: isOldPass,
                           child: const Text(
                             'Mật khẩu cũ không đúng',
                             style: TextStyle(
                               fontSize: 12,
                               fontFamily: 'Inter',
                               color: Color(0xffFF0000),
                             ),
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         child: TextField(
                           controller: txtPass,
                           obscureText: displayPass,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(
                                   color: Color(0xff009DE5), width: 2.0),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(
                                   color: isOldPass == false
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
                             labelText: 'Mật khẩu cũ',
                             labelStyle: TextStyle(fontSize: 16, color: Color(0xff696969)),
                           ),
                           style: const TextStyle(
                               color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                           onChanged: (value){
                             /*setState(() {
                               Pass = value;
                               if (!validateStructure(Pass))
                                 isOldPass = true;
                               else
                                 isOldPass = false;
                             });*/
                           },
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         width: double.infinity,
                         alignment: Alignment.centerRight,
                         child: Visibility(
                           visible: isPass,
                           child: const Text(
                             'Mật khẩu ít nhất có 6 ký tự chữ hoa, chữ thường và số',
                             style: TextStyle(
                               fontSize: 12,
                               fontFamily: 'Inter',
                               color: Color(0xffFF0000),
                             ),
                           ),
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         child: TextField(
                           controller: txtnewPass,
                           obscureText: displayPass,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(
                                   color: Color(0xff009DE5), width: 2.0),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(
                                   color: isPass == false
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
                             labelText: 'Mật khẩu mới',
                             labelStyle: TextStyle(fontSize: 16, color: Color(0xff696969)),
                           ),
                           style: const TextStyle(
                               color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                           onChanged: (value){
                             setState(() {
                               newPass = value;
                               if (!validateStructure(newPass))
                                 isPass = true;
                               else
                                 isPass = false;
                             });
                           },
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         width: double.infinity,
                         alignment: Alignment.centerRight,
                         child: Visibility(
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
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                         child: TextField(
                           controller: txtrenewPass,
                           obscureText: displayPass,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: const BorderSide(
                                   color: Color(0xff009DE5), width: 2.0),
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
                             labelText: 'Nhập lại mật khẩu mới',
                             labelStyle: TextStyle(fontSize: 16, color: Color(0xff696969)),
                           ),
                           style: const TextStyle(
                               color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                           onChanged: (value){
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
                       ),
                       const SizedBox(
                         height: 20,
                       ),
                       SizedBox(
                         height: 40,
                         width: double.infinity,
                         child: ElevatedButton(
                           onPressed: displayButton ? () async  {
                             setState(() async {
                               changPassRequestModel.confirmPassword = txtrenewPass.text;
                               changPassRequestModel.newPassword=txtnewPass.text;
                               changPassRequestModel.oldPassword=txtPass.text;
                               APIChangePass apiChangepass = APIChangePass();
                               int statuscode = await apiChangepass.sendResponse(changPassRequestModel);
                               if(statuscode == 200){
                                 showSucces();
                                 apiChangepass.sendChangePass(changPassRequestModel);
                                 txtPass.text='';
                                 txtnewPass.text='';
                                 txtrenewPass.text='';
                               }else{
                                 showAlert();
                               }
                             });
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
                             'Lưu',
                             style: TextStyle(
                                 fontFamily: 'Inter',
                                 fontWeight: FontWeight.w500,
                                 fontSize: 14),
                           ),
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
   bool validateStructure(String value) {
     String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
     RegExp regExp = new RegExp(pattern);
     return regExp.hasMatch(value);
   }
   void showAlert() {
     showDialog(
       context: context,
       builder: (ctx) => AlertDialog(
         title: const Text("Thông báo"),
         content: Text("Mật khẩu cũ không đúng!!!"),
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
   void showSucces() {
     showDialog(
       context: context,
       builder: (ctx) => AlertDialog(
         title: const Text("Thông báo"),
         content: Text("Mật khẩu đã được thay đổi!"),
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
 