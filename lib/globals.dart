import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String endPoint = "http://101.53.149.34:4444";

List<String> BookingType_lst = <String>['Select booking-type'];
List<String> prayertype_lst = <String>['Select prayer-type'];

SharedPreferences? prefs;

String Uid = '';

String BTYp = '';
String PTYp = '';
String date = '';
String time = '';

strToLst(String str) {
  List lst;
  lst = str.split(",");
  return lst;
}

loading() {
  return Container(
    height: 100,
    width: 100,
    child: CircularProgressIndicator(),
  );
}

class church {
  static String ch_Nm = '';
  static String ch_id = '';
  static String desc = '';
  static String imglnk = '';
  static List ch_idLst = [''];
  static List<String> ch_NmLst = <String>['Select Church Name'];
}

List<String> CLst = <String>['Select Country'];
List<String> SLst = <String>['Select State'];
List<String> CTLst = <String>['Select City'];

String? cdropdownValues = CLst.first;
String? sdropdownValues = SLst.first;
String? ctdropdownValues = CTLst.first;
String? chdropdownValues = church.ch_NmLst.first;

class region {
  static String c_id = '';
  static String c_nm = '';
  static String s_id = '';
  static String s_nm = '';
  static String ct_id = '';
  static String ct_nm = '';
  static List c_idLst = [];
  static List c_nmLst = [];
  static List s_idLst = [];
  static List s_nmLst = [];
  static List ct_idLst = [];
  static List ct_nmLst = [];
}

class booking {
  static String bk_booktype = '';
  static String bk_prayertype = '';
  static String bk_prdate = '';
  static String bk_slot = '';
  static String status = '';
  static String bid = '';
}

void ToastMsg(String msg) {
  Get.snackbar("Alert", msg, snackPosition: SnackPosition.TOP);
}
