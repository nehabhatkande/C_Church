import 'dart:convert';

import 'package:cchurch/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

class CompletedCrd extends StatefulWidget {
  const CompletedCrd({super.key, required this.dm});
  final completed_models dm;
  @override
  State<CompletedCrd> createState() => _CompletedCrdState();
}

class _CompletedCrdState extends State<CompletedCrd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print(widget.dm.b_id);
        },
        child: Container(
          height: 150,
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
            ],
          ),
        ),
      ),
    );
  }

  // ======================asyn==========================
}
