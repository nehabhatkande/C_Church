import 'dart:convert';
import 'package:cchurch/globals.dart' as glb;
import 'package:cchurch/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController email_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();
  TextEditingController Cpswd_cont = TextEditingController();
  String email = '';
  bool pswd_vis = false, Cpswd_vis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Text(
                'Email',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 200,),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                height: 60,
                child: TextField(
                  controller: email_cont,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black38)),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      email = email_cont.text;
                      loginAsync();
                    },
                    // style: ElevatedButton.styleFrom(
                    //   primary: Colors.blue,
                    // ),
                    child: Text('Reset Password'),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: pswd_vis,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        height: 60,
                        child: TextField(
                          controller: pswd_cont,
                          obscureText: true,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.black38)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: Cpswd_vis,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        height: 60,
                        child: TextField(
                          controller: Cpswd_cont,
                          obscureText: true,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Colors.black38)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                  visible: pswd_vis,
                  child: ElevatedButton(
                      onPressed: () {
                        var a = pswd_cont.text;
                        var b = Cpswd_cont.text;
                        if (a == b) {
                          ChangePswd_async(a);
                        } else {
                          print('passwords do not match');
                        }
                      },
                      child: Text('Submit')))
            ],
          ),
        ),
      ),
    );
  }

  // ======= Asyncs ===============
  loginAsync() async {
    var tlvStr = "select user_id from prayer.user where email = '$email'; ";
    print(" login tlv: $tlvStr");
    String url = glb.endPoint;

    final Map dict = {"tlvNo": "709", "query": tlvStr, "uid": "-1"};

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dict));

      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        if (res.contains("ErrorCode#2")) {
          print('e2');
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var usrid = userMap['1'];
            // var usrname = userMap['2'];
            // var rcvpswd = userMap['3'];
            print('rcv pswd = $usrid');
            glb.Uid = usrid;
            setState(() {
              pswd_vis = true;
              Cpswd_vis = true;
            });
            // print(password);
            // if (rcvpswd == password) {
            //   // Navigator.push(context,
            //   //     MaterialPageRoute(builder: (context) => MainHomePage()));
            // } else {
            //   print('Wrong password');
            // }
          } catch (e) {
            print(e);
            return "Failed";
          }
        }
      }
    } catch (e) {
      setState(() {
        // showLoading = true;
      });
      Navigator.pop(context);
      if (e.toString().contains('Connection failed')) {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
      }
      print("handle Exception here::$e");
      if (e.toString().contains("XMLHttpRequest")) {
        print('no net handle here');
        return;
      }
      if (e.toString() == "Connection reset by peer") {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
        return;
      }
      if (e.toString().contains("Connection refused")) {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
        return;
      } else if (e.toString().contains("Operation timed out")) {
        // CNDGlb.showSnackBar(context, 'Operation Timed Out');
        return;
      } else if (e.toString().contains("Connection timed out")) {
        // CNDGlb.showSnackBar(context, 'Operation Timed Out');
        return;
      }
    }

    return "Success";
  }

  ChangePswd_async(String pswd) async {
    var tlvStr =
        "update prayer.user set password = '${pswd}' where user_id = '${glb.Uid}'";
    print(" login tlv: $tlvStr");
    String url = glb.endPoint;

    final Map dict = {"tlvNo": "714", "query": tlvStr, "uid": "-1"};

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dict));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        if (res.contains("ErrorCode#2")) {
          print('e2');
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else if (res.contains("ErrorCode#0")) {
          print("pswd updated");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var usrid = userMap['1'];
            // var usrname = userMap['2'];
            // var rcvpswd = userMap['3'];
            print('rcv pswd = $usrid');
            glb.Uid = usrid;
            setState(() {
              pswd_vis = true;
              Cpswd_vis = true;
            });
            // print(password);
            // if (rcvpswd == password) {
            //   // Navigator.push(context,
            //   //     MaterialPageRoute(builder: (context) => MainHomePage()));
            // } else {
            //   print('Wrong password');
            // }
          } catch (e) {
            print(e);
            return "Failed";
          }
        }
      }
    } catch (e) {
      setState(() {
        // showLoading = true;
      });
      Navigator.pop(context);
      if (e.toString().contains('Connection failed')) {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
      }
      print("handle Exception here::$e");
      if (e.toString().contains("XMLHttpRequest")) {
        print('no net handle here');
        return;
      }
      if (e.toString() == "Connection reset by peer") {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
        return;
      }
      if (e.toString().contains("Connection refused")) {
        // CNDGlb.showSnackBar(
        //     context, 'No Internet Connection Found / Server is Down');
        return;
      } else if (e.toString().contains("Operation timed out")) {
        // CNDGlb.showSnackBar(context, 'Operation Timed Out');
        return;
      } else if (e.toString().contains("Connection timed out")) {
        // CNDGlb.showSnackBar(context, 'Operation Timed Out');
        return;
      }
    }

    return "Success";
  }
}
