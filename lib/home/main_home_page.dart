import 'dart:convert';

import 'package:cchurch/Cards/church_card.dart';
import 'package:cchurch/home/church_page_body.dart';
import 'package:cchurch/home/drawerfolder/alert_dialog.dart';
import 'package:cchurch/home/drawerfolder/profile.dart';
import 'package:cchurch/userfolder/Ubookingpage.dart';
import 'package:cchurch/utils/colors.dart';
import 'package:cchurch/widgets/big_text.dart';
import 'package:cchurch/widgets/small_text.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:cchurch/home/mapdropdown.dart';

import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

import '../models/ch_model.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  String? dropdownValue;
  // String title = 'alertDailog';

  @override
  void initState() {
    // TODO: implement initState
    ch_det();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 230, 230),
      appBar: AppBar(
          toolbarHeight: 100,
          title: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                print("map display");
                return MapDropdown();
              }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.location_on), Text("Select Location")],
            ),
          )),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            ch_det();
          },
          child: Column(
            children: [
              Expanded(
                  child: isLoading
                      ? Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: glb.loading(),
                          ),
                        )
                      : SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UBookingPage(
                                        pg: 'All',
                                      );
                                    }));
                                  },
                                  child: Text('All Booking'),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: cm.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Ch_card(
                                        dm: cm[index],
                                      );
                                    }),
                              ),
                            ],
                          )))
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/logo1.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: null,
            ),
            SizedBox(
              height: 30,
            ),
            ListTileTheme(
              style: ListTileStyle.list,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditProfilePage()));
                },
              ),
            ),
            ListTileTheme(
              style: ListTileStyle.list,
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Help'),
                onTap: () {
                  // Handle the action when Home is tapped.
                },
              ),
            ),
            ListTileTheme(
              style: ListTileStyle.list,
              child: ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                onTap: () {
                  // Handle the action when Home is tapped.
                },
              ),
            ),
            SizedBox(
              height: 200,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Container(
                child: ElevatedButton(
                  onPressed: () async {
                    showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //==================================
  bool isLoading = true;
  List<ch_model> cm = [];
  ch_det() async {
    glb.Uid = glb.prefs!.getString('userId')!;
    cm = [];
    print('Church details async 1');
    setState(() {
      isLoading = true;
    });
    var tlvStr =
        " select  ch_name,ch_id,imglnk,description from prayer.church where city = '${glb.region.ct_nm}';";
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
            var Ch_img = userMap['3'];
            var desc = userMap['4'];

            print('rcv pswd = $ch_NM');
            print('rcv pswd = $Ch_id');
            print('rcv pswd = $Ch_img');

            print('nnnnnn');
            List ch_nmLst = glb.strToLst(ch_NM);
            List ch_idLst = glb.strToLst(Ch_id);
            List ch_imgLst = glb.strToLst(Ch_img);
            List descLst = glb.strToLst(desc);
            print('MMMM');
            print(ch_imgLst.last);

            for (int i = 0; i < ch_imgLst.length; i++) {
              if (ch_imgLst[i] == 'NA') {
                ch_imgLst[i] =
                    'https://img.freepik.com/free-vector/gradient-church-building-illustration_23-2149452604.jpg?w=740&t=st=1688970681~exp=1688971281~hmac=5348e82b020e9de00ae07ab13ff77d14f1caaf9b81d2f218c783faad571548a2';
              }
            }
            for (int i = 0; i < ch_idLst.length; i++) {
              cm.add(ch_model(
                  ch_id: ch_idLst.elementAt(i),
                  ch_nm: ch_nmLst.elementAt(i),
                  ch_img: ch_imgLst.elementAt(i),
                  desc: descLst.elementAt(i)));
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

  late DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    print("will pop");
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      glb.ToastMsg("Exit");
      print("exit");
      return Future.value(true);
    }
    print("exit 1");
    return Future.value(true);
  }
  //
}
