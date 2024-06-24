import 'dart:convert';

import 'package:cchurch/largepage/add_booking.dart';
import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/mainpage/save_booking.dart';
import 'package:cchurch/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:http/http.dart' as http;

class AllBook_cards extends StatefulWidget {
  const AllBook_cards({super.key, required this.bcards, required this.pg});
  final allbook_models bcards;
  final String pg;

  @override
  State<AllBook_cards> createState() => _AllBook_cards();
}

var btn;
bool vis = true;

class _AllBook_cards extends State<AllBook_cards> {
  @override
  void initState() {
    // TODO: implement initState
    if (widget.pg == "payment") {
      vis = true;
      btn = payment_btn();
    } else if (widget.pg == "Cancel") {
      vis = true;
      btn = cancel_btn();
    } else {
      vis = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            glb.booking.bid = widget.bcards.bid;
            glb.booking.bk_booktype = widget.bcards.bk_booktype;
            glb.booking.bk_prayertype = widget.bcards.bk_prayertype;
            glb.booking.bk_prdate = widget.bcards.bk_prdate;
            glb.booking.bk_slot = widget.bcards.bk_slot;
            glb.booking.status = widget.bcards.status;
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaveBooking()),
          );
        },
        child: Container(
          height: 200,
          color: Color.fromARGB(255, 190, 164, 190),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.bcards.img),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.book),
                    Text(widget.bcards.ch_nm),
                    Text('Booking Type: ${widget.bcards.bk_booktype}'),
                    Text('Prayer Type: ${widget.bcards.bk_prayertype}'),
                    Text('Date: ${widget.bcards.bk_prdate}'),
                    Text('Time: ${widget.bcards.bk_slot}'),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Visibility(visible: vis, child: btn)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  payment_btn() {
    return ElevatedButton(onPressed: () {},
     child: Text("Pay"));
  }

  cancel_btn() {
    return ElevatedButton(
        onPressed: () {
          glb.booking.bid = widget.bcards.bid;
          print(widget.bcards.bid);
          Delete_booking();
        },
        child: Text("cancel"));
  }

  // =====================
  Delete_booking() async {
    var tlvStr = "delete from prayer.booking where b_id = '${glb.booking.bid}'";
    print(" submit tlv: $tlvStr");
    String url = glb.endPoint;

    final Map dict = {"tlvNo": "714", "query": tlvStr, "uid": "-1"};

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Accept": "application/json",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dict));
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
          print('Done');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SaveBooking()));
          return;
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
            print("userMap:$userMap");
            var Pid = userMap['1'];
            var PTyp = userMap['2'];

            print('pid = $Pid');
            print('ptype = $PTyp');

            List pid_lst = glb.strToLst(Pid);
            List pType_lst = glb.strToLst(PTyp);
            print('length = ${pType_lst.length}');

            setState(() {
              myList.removeRange(1, myList.length);
              print(myList);
              for (int i = 0; i < pType_lst.length; i++) {
                print(pType_lst[i].toString());
                myList.add(pType_lst[i].toString());
                print(myList);
              }
              // myLst = glb.BookingType_lst;
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
