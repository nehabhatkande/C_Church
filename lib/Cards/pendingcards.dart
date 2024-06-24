import 'dart:convert';

import 'package:cchurch/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

class PendingCrd extends StatefulWidget {
  const PendingCrd({super.key, required this.dm});
  final pending_models dm;
  @override
  State<PendingCrd> createState() => _PendingCrdState();
}

class _PendingCrdState extends State<PendingCrd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print(widget.dm.b_id);
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Date: ${widget.dm.pr_date}'),
              Text('Slot: ${widget.dm.slot}'),
              Text('Booking Type:${widget.dm.booktype}'),
              Text('Prayer Type: ${widget.dm.prayertype}'),

              // Text(widget.dm.sts),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        SizedBox(
                          height: 15,
                        );
                        glb.booking.bid = widget.dm.b_id;
                        stsUpdt_Async();
                      },
                      child: Text('Confirm Booking for Payment'),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Cancel Booking'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ======================asyn==========================
  stsUpdt_Async() async {
    var tlvStr =
        "update prayer.booking set status = '1' where b_id = '${glb.booking.bid}';";
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
          print("done");
        } else {
          try {
            Map<String, dynamic> userMap = json.decode(response.body);
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
}
