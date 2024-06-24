import 'dart:convert';

import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/utils/colors.dart';
import 'package:cchurch/utils/dimensions.dart';
import 'package:cchurch/widgets/app_column.dart';
import 'package:cchurch/widgets/big_text.dart';
import 'package:cchurch/widgets/icon_and_text_widget.dart';
import 'package:cchurch/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

import '../Cards/church_card.dart';
import '../models/ch_model.dart';

class ChurchPageBody extends StatefulWidget {
  const ChurchPageBody({super.key});

  @override
  State<ChurchPageBody> createState() => _ChurchPageBodyState();
}

class _ChurchPageBodyState extends State<ChurchPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  // double _scaleFactor = 0.8;
  // double _height = 220;

  @override
  void initState() {
    super.initState();
    ch_det();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        ch_det();
      },
      child: Column(
        children: [
          isLoading
              ? glb.loading()
              : Flexible(
                  child: ListView.builder(
                      itemCount: cm.length,
                      itemBuilder: (BuildContext context, index) {
                        return Ch_card(
                          dm: cm[index],
                        );
                      }),
                )
        ],
      ),
    );
  }

  

  // =========== async =============
  bool isLoading = true;
  List<ch_model> cm = [];
  ch_det() async {
    setState(() {
      isLoading = true;
    });
    var tlvStr =
        " select  ch_name,ch_id,imglnk,description from prayer.church where country='India';";
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
}
