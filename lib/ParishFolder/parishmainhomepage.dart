import 'package:cchurch/ParishFolder/TabBarScreens/completed_scrn.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/upcoming_scrn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'TabBarScreens/pending_scrn.dart';

class ParishMainHomePage extends StatefulWidget {
  const ParishMainHomePage({super.key});

  @override
  State<ParishMainHomePage> createState() => _ParishMainHomePageState();
}

class _ParishMainHomePageState extends State<ParishMainHomePage> {
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
                    text: "Pending",
                  ),
                  Tab(
                    text: "UpComing",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              ),
              title: Text('Parish Officer Booking Status'),
            ),
            body: TabBarView(children: [
              pending_scrn(),
              UpComingsrn(),
              Completedscrn(),
            ])),
      ),
    );
  }
}
