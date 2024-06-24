import 'package:flutter/material.dart';

class temp extends StatefulWidget {
  const temp({super.key});

  @override
  State<temp> createState() => _tempState();
}

List tb = ['Home', 'Explore'];

class _tempState extends State<temp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tb.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('home 2'),
          bottom: TabBar(tabs: [Text('home'), Text('Explore')]),
        ),
        body: TabBarView(children: []),
      ),
    );
  }
}
