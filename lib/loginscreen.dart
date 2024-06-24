import 'dart:convert';

import 'package:cchurch/home/main_home_page.dart';
import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/mainpage/map_and_bookpage.dart';
import 'package:cchurch/home/map_page.dart';
import 'package:cchurch/signup.dart';
import 'package:cchurch/utils/SharedPreferenceUtils.dart';
import 'package:cchurch/widgets/forgot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ParishFolder/parishmainhomepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  TextEditingController _userNM = TextEditingController();
  TextEditingController _Pswd = TextEditingController();

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
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
                offset: Offset(0, 2),
              )
            ],
          ),
          height: 60,
          child: TextField(
            controller: _userNM,
            // keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
            ],

            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            obscureText: true,
            controller: _Pswd,
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
        )
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ForgotPass();
              }));
            },
            child: Text(
              'Forgot Password',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(0.0)),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.white,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  isRememberMe = !isRememberMe;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          primary: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          var username = _userNM.text;
          var pswd = _Pswd.text;
          print('btn pressed');
          // loginAsync(username, pswd);
          if (username.isNotEmpty && pswd.isNotEmpty) {
            print('non empty');
            loginAsync(username, pswd);
          } else {
            glb.ToastMsg("Enter valid details");
            print('empty');
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  // Widget buildGoogleBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 40),
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       style: ElevatedButton.styleFrom(
  //         elevation: 10,
  //         primary: Colors.white,
  //         onPrimary: Colors.black38,
  //       ),
  //       onPressed: () {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
  //           return MapAndBookPage();
  //         }));
  //       },
  //       icon: Image.asset(
  //         'assets/images/google.png',
  //         height: 25,
  //       ),
  //       label: Text(
  //         'Sign in with Google',
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupPage())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account?\t',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: 'SignUp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFFF0F3F4),
                      Color(0xFFF0F3F4),
                      Color(0xFFF0F3F4),
                      Color(0xFFF0F3F4),
                    ])),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      buildEmail(),
                      SizedBox(height: 20),
                      buildPassword(),
                      buildForgotPassBtn(),
                      buildRememberCb(),
                      buildLoginBtn(),
                      // Column(
                      //   children: <Widget>[
                      //     Text(
                      //       '-OR-',
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // ),
                      // buildGoogleBtn(),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======= Asyncs ===============
  loginAsync(String usrName, String password) async {
    var tlvStr =
        "select user_id,usr_nm,password,usertype,ch_id from prayer.user where usr_nm = '$usrName'; ";
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
            var usrname = userMap['2'];
            var rcvpswd = userMap['3'];
            var usertype = userMap['4'];
            var ch_id = userMap['5'];
            if (usertype.toString() == "1") {}
            print('rcv pswd = $rcvpswd');
            glb.Uid = usrid;
            glb.church.ch_id = ch_id;
            print(password);
            if (rcvpswd == password && usertype.toString() == "0") {
              SharedPreferenceUtils.save_val('userId', usrid);
              SharedPreferenceUtils.save_val("uTyp", usertype);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainHomePage()));
            } else if (rcvpswd == password && usertype.toString() == "1") {
              SharedPreferenceUtils.save_val('userId', usrid);
              SharedPreferenceUtils.save_val("uTyp", usertype);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParishMainHomePage()));
            } else {
              print('Wrong password');
            }
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
