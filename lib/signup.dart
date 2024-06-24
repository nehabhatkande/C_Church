import 'dart:convert';

import 'package:cchurch/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:cchurch/home/mapdropdown.dart' as md;

class SignupPage extends StatefulWidget {
  State<SignupPage> createState() => _SignupPageState();
}

bool isParishOfficer = false;
String selectedCountry = '';

class _SignupPageState extends State<SignupPage> {
  TextEditingController _userNM = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _useremail = TextEditingController();
  TextEditingController _Pswd = TextEditingController();
  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
            controller: _userNM,
            keyboardType: TextInputType.emailAddress,
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
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildMNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mobile Number',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
            controller: _number,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{10}$')),
            // ],
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                hintText: 'Mobile Number',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
            controller: _useremail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9@.]+$')),
            ],
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
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
            controller: _Pswd,
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
        )
      ],
    );
  }

  Widget buildParish() {
    // bool isParishOfficer = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: Row(
          children: [
            Checkbox(
              value: isParishOfficer,
              onChanged: (bool? newValue) {
                setState(() {
                  isParishOfficer = newValue!;
                  print("check = $isParishOfficer");
                });
              },
            ),
            Text(
              "I am Parish Officer",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountry() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: glb.cdropdownValues,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(),
            onChanged: (String? value) {
              print("change");
              var idx;
              setState(() {
                print(value!);
                glb.cdropdownValues = value!;
                glb.region.c_nm = glb.cdropdownValues!;
                idx = glb.region.c_nmLst.indexOf(glb.region.c_nm);
                glb.region.c_id = glb.region.c_idLst.elementAt(idx);

                getState();
              });
              print(idx);
            },
            items: glb.CLst.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildState() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: DropdownButton<String>(
          value: glb.sdropdownValues,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(),
          onChanged: (String? value) {
            print('change');
            var idx1;
            setState(() {
              print(value!);
              glb.sdropdownValues = value!;
              glb.region.s_nm = glb.sdropdownValues!;
              idx1 = glb.region.s_nmLst.indexOf(glb.region.s_nm);
              glb.region.s_id = glb.region.s_idLst.elementAt(idx1);
              getCity();
            });
          },
          items: glb.SLst.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildCity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: DropdownButton<String>(
          value: glb.ctdropdownValues,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(),
          onChanged: (String? value) {
            print('change');
            var idx2;
            setState(() {
              print(value!);
              glb.ctdropdownValues = value!;
              glb.region.ct_nm = glb.ctdropdownValues!;
              idx2 = glb.region.ct_nmLst.indexOf(glb.region.ct_nm);
              glb.region.ct_id = glb.region.ct_idLst.elementAt(idx2);
              ch_det();
            });
          },
          items: glb.CTLst.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildChurchLst() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: glb.chdropdownValues,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(),
            onChanged: (String? value) {
              print("change");
              var idx;
              setState(() {
                print(value!);
                glb.chdropdownValues = value!;
                glb.church.ch_Nm = glb.chdropdownValues!;
                idx = glb.church.ch_NmLst.indexOf(glb.church.ch_Nm) - 1;
                print(glb.church.ch_idLst[idx]);
                glb.church.ch_id = glb.church.ch_idLst[idx];
                print("index = $idx");
                // print(glb.church.ch_NmLst.indexOf(glb.chdropdownValues!));
              });
              print(idx);
            },
            items: glb.church.ch_NmLst
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget RegisterBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 5),
        onPressed: () {
          var nm = _userNM.text;
          var pd = _Pswd.text;
          var em = _useremail.text;
          var num = _number.text;
          if (nm.isNotEmpty && pd.isNotEmpty && em.isNotEmpty) {
            print('non empty');
            SignupAsync(nm, pd, em, num);
          } else {
            glb.ToastMsg("Enter valid details");
            print('empty');
          }
        },
        child: Text(
          'Register',
          style: TextStyle(
              color: Colors.black38, fontWeight: FontWeight.bold, height: 4),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    glb.CLst.removeRange(1, glb.CLst.length);
    glb.SLst.removeRange(1, glb.SLst.length);
    glb.CTLst.removeRange(1, glb.CTLst.length);
    glb.church.ch_NmLst.removeRange(1, glb.church.ch_NmLst.length);
    getCountry();
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
                      ]),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      buildName(),
                      SizedBox(
                        height: 30,
                      ),
                      buildMNumber(),
                      SizedBox(
                        height: 30,
                      ),
                      buildEmail(),
                      SizedBox(
                        height: 30,
                      ),
                      buildPassword(),
                      SizedBox(
                        height: 30,
                      ),
                      buildParish(),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                          visible: isParishOfficer, child: buildCountry()),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(visible: isParishOfficer, child: buildState()),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(visible: isParishOfficer, child: buildCity()),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                          visible: isParishOfficer, child: buildChurchLst()),
                      SizedBox(
                        height: 30,
                      ),
                      RegisterBtn(context),
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
  SignupAsync(
      String usrName, String password, String email, String number) async {
    String usrTyp;
    var tlvStr;
    if (isParishOfficer == true) {
      usrTyp = "1";
      tlvStr =
          "insert into prayer.user(usr_nm,email,password,number,usertype,ch_id) values('$usrName','$email','$password','$number','$usrTyp','${glb.church.ch_id}');";
    } else {
      usrTyp = "0";
      tlvStr =
          "insert into prayer.user(usr_nm,email,password,number,usertype) values('$usrName','$email','$password','$number','$usrTyp');";
    }
    print("sent = ${tlvStr}");
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
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else if (res.contains("ErrorCode#0")) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var usrid = userMap['1'];
            var usrname = userMap['2'];
            var rcvpswd = userMap['3'];
            print('rcv pswd = $rcvpswd');
            print(password);
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
      }
    }

    return "Success";
  }

  bool isLoading = true;
  getCountry() async {
    glb.CLst.removeRange(1, glb.CLst.length);
    glb.SLst.removeRange(1, glb.SLst.length);
    glb.CTLst.removeRange(1, glb.CTLst.length);
    glb.church.ch_NmLst.removeRange(1, glb.church.ch_NmLst.length);
    glb.Uid = glb.prefs!.getString('userId')!;
    glb.ctdropdownValues = glb.CTLst.first;
    glb.sdropdownValues = glb.SLst.first;
    glb.cdropdownValues = glb.CLst.first;
    glb.chdropdownValues = glb.church.ch_NmLst.first;
    print('Church details async');
    setState(() {
      isLoading = true;
    });
    var tlvStr = "select c_id,c_name from prayer.country;";
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
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var c_id = userMap['1'];
            var c_nm = userMap['2'];

            print('c_id = $c_id');
            print('c nm= $c_id');

            print('nnnnnn');
            List c_idLst = glb.strToLst(c_id);
            List c_nmLst = glb.strToLst(c_nm);

            glb.region.c_idLst = c_idLst;
            glb.region.c_nmLst = c_nmLst;

            for (int i = 0; i < c_idLst.length; i++) {
              glb.CLst.add(c_nmLst[i]);
            }

            setState(() {
              isLoading = false;
            });
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

  //==============================
  getState() async {
    glb.SLst.removeRange(1, glb.SLst.length);
    glb.CTLst.removeRange(1, glb.CTLst.length);
    glb.church.ch_NmLst.removeRange(1, glb.church.ch_NmLst.length);

    glb.sdropdownValues = glb.SLst.first;
    glb.ctdropdownValues = glb.CTLst.first;
    glb.chdropdownValues = glb.church.ch_NmLst.first;
    print('Church details async');
    setState(() {
      isLoading = true;
    });
    var tlvStr =
        "select s_id,s_name from prayer.state where c_id = ${glb.region.c_id};";
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
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var s_id = userMap['1'];
            var s_nm = userMap['2'];

            print('s_id = $s_id');
            print('s nm= $s_id');

            print('nnnnnn');
            List s_idLst = glb.strToLst(s_id);
            List s_nmLst = glb.strToLst(s_nm);

            glb.region.s_idLst = s_idLst;
            glb.region.s_nmLst = s_nmLst;

            for (int i = 0; i < s_idLst.length; i++) {
              glb.SLst.add(s_nmLst[i]);
            }

            setState(() {
              isLoading = false;
            });
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

  // ==================================
  getCity() async {
    glb.CTLst.removeRange(1, glb.CTLst.length);
    glb.church.ch_NmLst.removeRange(1, glb.church.ch_NmLst.length);

    glb.ctdropdownValues = glb.CTLst.first;
    glb.chdropdownValues = glb.church.ch_NmLst.first;
    print('Church details async');
    setState(() {
      isLoading = true;
    });
    var tlvStr =
        "select ct_id,ct_name from prayer.city where s_id = '${glb.region.s_id}';";
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
          // glb.showSnackBar(context, 'Error', 'You are not registered');
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var ct_id = userMap['1'];
            var ct_nm = userMap['2'];

            print('ct_id = $ct_id');
            print('ct nm= $ct_id');

            print('nnnnnn');
            List ct_idLst = glb.strToLst(ct_id);
            List ct_nmLst = glb.strToLst(ct_nm);

            glb.region.ct_idLst = ct_idLst;
            glb.region.ct_nmLst = ct_nmLst;

            for (int i = 0; i < ct_idLst.length; i++) {
              glb.CTLst.add(ct_nmLst[i]);
            }

            setState(() {
              isLoading = false;
            });
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

  ch_det() async {
    glb.church.ch_NmLst.removeRange(1, glb.church.ch_NmLst.length);
    glb.Uid = glb.prefs!.getString('userId')!;
    // cm = [];
    print('Church details async 1');
    setState(() {
      isLoading = true;
    });
    var tlvStr =
        " select  ch_name,ch_id from prayer.church where city = '${glb.region.ct_nm}';";
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
        print("res==> $res");
        if (res.contains("ErrorCode#2")) {
          print("E2");
          setState(() {
            isLoading = false;
          });
          return;
        } else if (res.contains("ErrorCode#8")) {
          // glb.showSnackBar(context, 'Error', 'Something Went Wrong');
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var ch_NM = userMap['1'];
            var Ch_id = userMap['2'];

            print('rcv pswd = $ch_NM');
            print('rcv pswd = $Ch_id');

            print('nnnnnn');
            List ch_nmLst = glb.strToLst(ch_NM);
            List ch_idLst = glb.strToLst(Ch_id);
            glb.church.ch_idLst = ch_idLst;
            for (int i = 0; i < ch_nmLst.length; i++) {
              glb.church.ch_NmLst.add(ch_nmLst[i]);
            }
            print('MMMM');

            setState(() {
              isLoading = false;
            });
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
