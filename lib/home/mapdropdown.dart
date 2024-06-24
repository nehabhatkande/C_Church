import 'dart:convert';

import 'package:cchurch/home/main_home_page.dart';
import 'package:cchurch/utils/SharedPreferenceUtils.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

import '../routings/route_names.dart';

List<String> CLst = <String>['Select Country'];
List<String> SLst = <String>['Select State'];
List<String> CTLst = <String>['Select City'];

class MapDropdown extends StatefulWidget {
  @override
  _MapDropdownState createState() => _MapDropdownState();
}

class _MapDropdownState extends State<MapDropdown> {
  @override
  void initState() {
    // TODO: implement initState
    CLst.removeRange(1, CLst.length);
    SLst.removeRange(1, SLst.length);
    CTLst.removeRange(1, CTLst.length);
    getCountry();
  }

  String? cdropdownValues = CLst.first;
  String? sdropdownValues = SLst.first;
  String? ctdropdownValues = CTLst.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green,
                    // width: 2,
                  ),
                ),
                // country dropdown
                child: DropdownButton<String>(
                  value: cdropdownValues,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(),
                  onChanged: (String? value) {
                    print("change");
                    var idx;
                    setState(() {
                      print(value!);
                      cdropdownValues = value!;
                      glb.region.c_nm = cdropdownValues!;
                      idx = glb.region.c_nmLst.indexOf(glb.region.c_nm);
                      glb.region.c_id = glb.region.c_idLst.elementAt(idx);

                      getState();
                    });
                    print(idx);
                  },
                  items: CLst.map<DropdownMenuItem<String>>((String value) {
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
          ),
          SizedBox(
            height: 30,
          ),
          // State dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  // width: 2,
                ),
              ),
              child: DropdownButton<String>(
                value: sdropdownValues,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(),
                onChanged: (String? value) {
                  print('change');
                  var idx1;
                  setState(() {
                    print(value!);
                    sdropdownValues = value!;
                    glb.region.s_nm = sdropdownValues!;
                    idx1 = glb.region.s_nmLst.indexOf(glb.region.s_nm);
                    glb.region.s_id = glb.region.s_idLst.elementAt(idx1);
                    getCity();
                  });
                },
                items: SLst.map<DropdownMenuItem<String>>((String value) {
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  // width: 2,
                ),
              ),
              child: DropdownButton<String>(
                value: ctdropdownValues,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(),
                onChanged: (String? value) {
                  print('change');
                  var idx2;
                  setState(() {
                    print(value!);
                    ctdropdownValues = value!;
                    glb.region.ct_nm = ctdropdownValues!;
                    idx2 = glb.region.ct_nmLst.indexOf(glb.region.ct_nm);
                    glb.region.ct_id = glb.region.ct_idLst.elementAt(idx2);
                  });
                },
                items: CTLst.map<DropdownMenuItem<String>>((String value) {
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
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainhomepageRoute);
              SharedPreferenceUtils.save_val("city_nm", glb.region.ct_nm);
              SharedPreferenceUtils.save_val("city_id", glb.region.ct_id);
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  //============================================
  bool isLoading = true;
  getCountry() async {
    CLst.removeRange(1, CLst.length);
    SLst.removeRange(1, SLst.length);
    CTLst.removeRange(1, CTLst.length);
    glb.Uid = glb.prefs!.getString('userId')!;

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
              CLst.add(c_nmLst[i]);
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
    sdropdownValues = SLst.first;
    ctdropdownValues = CTLst.first;
    SLst.removeRange(1, SLst.length);
    CTLst.removeRange(1, CTLst.length);

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
              SLst.add(s_nmLst[i]);
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
    CTLst.removeRange(1, CTLst.length);
    ctdropdownValues = CTLst.first;
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
              CTLst.add(ct_nmLst[i]);
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
}
