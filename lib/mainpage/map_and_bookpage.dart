import 'package:cchurch/largepage/add_booking.dart';
import 'package:cchurch/home/map_page.dart';
import 'package:flutter/material.dart';

class MapAndBookPage extends StatefulWidget {
  const MapAndBookPage({Key? key}) : super(key: key);

  @override
  State<MapAndBookPage> createState() => _MapAndBookPageState();
}

class _MapAndBookPageState extends State<MapAndBookPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Book Location and Church'),
        ),
        body: Container(), // Replace with your content
        
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapBookingPage()),
                );
              },
              child: Icon(Icons.location_on),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBookingPage()),
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
