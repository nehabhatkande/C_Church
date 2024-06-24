import 'package:flutter/material.dart';

class MapBookingPage extends StatefulWidget {
  const MapBookingPage({super.key});

  @override
  State<MapBookingPage> createState() => _MapBookingPageState();
}

class _MapBookingPageState extends State<MapBookingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Location'),
        ),
      ),
    );
  }
}
