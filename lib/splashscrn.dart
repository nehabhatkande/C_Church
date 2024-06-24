import 'dart:async';

import 'package:cchurch/routings/route_names.dart';
import 'package:flutter/material.dart';
import 'package:cchurch/globals.dart' as glb;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _loadAsyncData() async {
    glb.prefs = await SharedPreferences.getInstance();
    var userId = glb.prefs!.getString('userId');
    var uType = glb.prefs!.getString('uTyp');
    glb.region.ct_id = glb.prefs!.getString('city_id')!;
    glb.region.ct_nm = glb.prefs!.getString('city_nm')!;
    print(">> $userId \n\n $uType");
    if (userId != null && userId!.isEmpty == false) {
      // ignore: use_build_context_synchronously
      print("main");
      Navigator.pushNamed(context, MainhomepageRoute);
    } else {
      print("else");
      Navigator.pushNamed(context, LoginscrnRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      _loadAsyncData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: false,
      child: SizedBox.expand(
        child: Stack(children: [
          Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/cross.gif',
                height: height,
                width: width,
                // width: 200,
                // height: 400,
              )),
        ]),
      ),
    );
  }
}
