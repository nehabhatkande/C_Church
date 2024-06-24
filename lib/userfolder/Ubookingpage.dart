import 'package:cchurch/Cards/book_cards.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/completed_scrn.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/upcoming_scrn.dart';
import 'package:cchurch/mainpage/save_booking.dart';
import 'package:cchurch/userfolder/TabBarScreens/payment_scrn.dart';
import 'package:cchurch/userfolder/TabBarScreens/ucompleted_scrn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'TabBarScreens/reqprayer_scrn.dart';

class UBookingPage extends StatefulWidget {
  const UBookingPage({super.key, required this.pg});
  final String pg;

  @override
  State<UBookingPage> createState() => _UBookingPageState();
}

class _UBookingPageState extends State<UBookingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Request Prayer",
                  ),
                  Tab(
                    text: "Payment",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              ),
              title: Text('Booking Status'),
            ),
            body: TabBarView(children: [
              ReqPrayer_scrn(pg: widget.pg),
              Payment_scrn(pg:widget.pg),
              UCompletedscrn(pg: widget.pg,),
            ])),
      ),
    );
  }
  // 
  
  // 
}
