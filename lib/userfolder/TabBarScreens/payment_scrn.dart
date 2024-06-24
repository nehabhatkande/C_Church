import 'dart:convert';

import 'package:cchurch/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

import '../../Cards/book_cards.dart';
import '../../Cards/pendingcards.dart';

class Payment_scrn extends StatefulWidget {
  const Payment_scrn({super.key, required this.pg});
  final String pg;
  @override
  State<Payment_scrn> createState() => _Payment_scrnState();
}

class _Payment_scrnState extends State<Payment_scrn> {
  @override
  void initState() {
    // TODO: implement initState
    pyr_typAsync();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: bm.length,
        itemBuilder: (BuildContext context, index) {
          return Book_cards(
            bcards: bm[index],
            pg: 'payment',
          );
        });
  }

  // ======================asyn==========================

  List<book_models> bm = [];
  pyr_typAsync() async {
    bm = [];
    var tlvStr =
        "select  booktype,prayertype,pr_date,slot,status,b_id from prayer.booking where user_id = '${glb.Uid}'and ch_id = '${glb.church.ch_id}' and status = '1';";
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

            var BTy = userMap['1'];
            var PTyp = userMap['2'];
            var date = userMap['3'];
            var slot = userMap['4'];
            var status = userMap['5'];
            var Bid = userMap['6'];

            print('bty = $BTy');
            print('ptype = $PTyp');
            print('date = $date');
            print('slot = $slot');
            print('status = $status');
            print('bid = $Bid');

            List bty_lst = glb.strToLst(BTy);
            List pType_lst = glb.strToLst(PTyp);
            List date_lst = glb.strToLst(date);
            List slot_lst = glb.strToLst(slot);
            List status_lst = glb.strToLst(status);
            List bid_lst = glb.strToLst(Bid);

            setState(() {
              print('length = ${pType_lst.length}');
              for (int i = 0; i < bty_lst.length; i++) {
                bm.add(book_models(
                  bk_booktype: bty_lst.elementAt(i),
                  bk_prayertype: pType_lst.elementAt(i),
                  bk_prdate: date_lst.elementAt(i),
                  bk_slot: slot_lst.elementAt(i),
                  status: status_lst.elementAt(i),
                  bid: bid_lst.elementAt(i),
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
