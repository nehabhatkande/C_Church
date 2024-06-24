import 'dart:convert';

import 'package:cchurch/mainpage/save_booking.dart';
import 'package:cchurch/models/ch_model.dart';
import 'package:cchurch/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cchurch/largepage/add_booking.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cchurch/largepage/add_booking.dart' as Dt;
import 'package:cchurch/globals.dart' as glb;
import 'package:http/http.dart' as http;

List<String> myLst = <String>['Booking type'];
List<String> myList = <String>['Prayer type'];

String selectedTime = '';

class AddBookingPage extends StatefulWidget {
  const AddBookingPage({Key? key}) : super(key: key);

  @override
  _AddBookingPageState createState() => _AddBookingPageState();
}

class _AddBookingPageState extends State<AddBookingPage> {
  String? dropdownValue = myLst.first;
  String? dropdownValues = myList.first;
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    bokg_typAsync();
    pyr_typAsync();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Church Booking'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Submit_booking();
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                    // width: 2,
                  ),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      glb.BTYp = dropdownValue!;
                    });
                  },
                  items: myLst.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                    // width: 2,
                  ),
                ),
                child: DropdownButton<String>(
                  value: dropdownValues,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(),
                  onChanged: (String? value) {
                    setState(() {
                      print(value!);
                      dropdownValues = value!;
                      glb.PTYp = dropdownValues!;
                    });
                  },
                  items: myList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    iconColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                    // hintText: Dt.toString(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      // firstDate: DateTime(2000),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat("yyyy-MM-dd").format(pickedDate);

                      setState(() {
                        dateController.text = formattedDate.toString();
                        glb.date = formattedDate.toString();

                        // Dt = formattedDate;
                      });
                    } else {
                      print("Not selected");
                    }
                  },
                ))),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  // width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {},
                          onConfirm: (date) {
                            setState(() {
                              // Format the selected time as desired
                              selectedTime = '${date.hour}:${date.minute}';
                              glb.time = selectedTime;
                            });
                            print('confirm ${date.hour}:${date.minute}:00');
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      child: Text(
                        'Select Time',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8, // Adjust this value to change the width
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(text: selectedTime),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //
  bokg_typAsync() async {
    var tlvStr = "select * from prayer.bookingtype;";
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
        print('res == $res');
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
            var Bid = userMap['1'];
            var BTyp = userMap['2'];

            print('bid = $Bid');
            print('btype = $BTyp');

            List bid_lst = glb.strToLst(Bid);
            List bType_lst = glb.strToLst(BTyp);
            print('length = ${bType_lst.length}');
            setState(() {
              myLst.removeRange(1, myLst.length);
              print(myLst);
              for (int i = 0; i < bType_lst.length; i++) {
                print(bType_lst[i].toString());
                myLst.add(bType_lst[i].toString());
                print(myLst);
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

  pyr_typAsync() async {
    var tlvStr = "select * from prayer.prayertype;";
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

  Submit_booking() async {
    var tlvStr =
        "insert into prayer.booking(user_id,ch_id,booktype,prayertype,pr_date,slot,status) values('${glb.Uid}','${glb.church.ch_id}','${glb.BTYp}','${glb.PTYp}','${glb.date}','${glb.time}','0')";
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
