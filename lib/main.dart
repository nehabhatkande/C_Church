import 'package:cchurch/home/church_page_body.dart';
import 'package:cchurch/home/main_home_page.dart';
import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/loginscreen.dart';
import 'package:cchurch/routings/route_names.dart';
import 'package:cchurch/routings/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter login UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginScreen(),
      initialRoute: SplashScreenRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
