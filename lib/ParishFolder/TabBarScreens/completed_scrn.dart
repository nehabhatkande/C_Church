import 'dart:convert';

import 'package:cchurch/Cards/completedcards.dart';
import 'package:cchurch/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

class Completedscrn extends StatefulWidget {
  const Completedscrn({super.key});

  @override
  State<Completedscrn> createState() => _CompletedscrnState();
}

class _CompletedscrnState extends State<Completedscrn> {
  @override
  void initState() {
    // TODO: implement initState
    completed_Async();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pm.length,
        itemBuilder: (BuildContext context, index) {
          return CompletedCrd(
            dm: pm[index],
          );
        });
  }

  // ============
  List<completed_models> pm = [];
  completed_Async() async {
    pm = [];
    var tlvStr =
        " select b_id,user_id,booktype,prayertype,pr_date,slot,status from prayer.booking where ch_id = ${glb.church.ch_id} and payment = '1';";
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

            var B_id = userMap['1'];
            var User_id = userMap['2'];
            var Booktype = userMap['3'];
            var Prayertype = userMap['4'];
            var Pr_date = userMap['5'];
            var Slot = userMap['6'];
            var status = userMap['7'];

            print('bid = $B_id');
            print('user_id = $User_id');
            print('booktype = $Booktype');
            print('prayertype = $Prayertype');
            print('pr_date = $Pr_date');
            print('slot = $Slot');
            print('status = $status');

            List bid_lst = glb.strToLst(B_id);
            List userid_lst = glb.strToLst(User_id);
            List booktype_lst = glb.strToLst(Booktype);
            List prayertype_lst = glb.strToLst(Prayertype);
            List prdate_lst = glb.strToLst(Pr_date);
            List slot_lst = glb.strToLst(Slot);
            List status_lst = glb.strToLst(status);

            setState(() {
              print('length = ${bid_lst.length}');
              for (int i = 0; i < userid_lst.length; i++) {
                pm.add(completed_models(
                  b_id: bid_lst.elementAt(i),
                  user_id: userid_lst.elementAt(i),
                  booktype: booktype_lst.elementAt(i),
                  prayertype: prayertype_lst.elementAt(i),
                  pr_date: prdate_lst.elementAt(i),
                  slot: slot_lst.elementAt(i),
                  sts: status_lst.elementAt(i),
                ));
              }
            });
          } catch (e) {
            print(e);
            return "Failed";
          }
        }
      }
    } catch (e) {
      // setState(() {
      //   // showLoading = true;
      // });
      // Navigator.pop(context);
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
