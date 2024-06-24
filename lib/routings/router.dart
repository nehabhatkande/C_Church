import 'package:cchurch/Cards/pendingcards.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/completed_scrn.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/pending_scrn.dart';
import 'package:cchurch/ParishFolder/TabBarScreens/upcoming_scrn.dart';
import 'package:cchurch/ParishFolder/parishmainhomepage.dart';
import 'package:cchurch/home/main_home_page.dart';
import 'package:cchurch/largepage/add_booking.dart';
import 'package:cchurch/largepage/event_calendar.dart';
import 'package:cchurch/largepage/recommended_church.dart';
import 'package:cchurch/loginscreen.dart';
import 'package:cchurch/mainpage/map_and_bookpage.dart';
import 'package:cchurch/routings/route_names.dart';
import 'package:cchurch/signup.dart';
import 'package:cchurch/userfolder/TabBarScreens/payment_scrn.dart';
import 'package:cchurch/userfolder/TabBarScreens/reqprayer_scrn.dart';
import 'package:cchurch/userfolder/TabBarScreens/ucompleted_scrn.dart';
import 'package:cchurch/userfolder/Ubookingpage.dart';
import 'package:flutter/material.dart';

import '../splashscrn.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case SplashScreenRoute:
      return _getPageRoute(const SplashScreen());
    case LoginscrnRoute:
      return _getPageRoute(LoginScreen());
    case SignupRoute:
      return _getPageRoute(SignupPage());
    case MainhomepageRoute:
      return _getPageRoute(const MainHomePage());
    case EventcalenderRoute:
      return _getPageRoute(const EventCalendarScreen());
    case AddbookingRoute:
      return _getPageRoute(const AddBookingPage());
    case RecommendedRoute:
      return _getPageRoute(const RecommendedChurch());
    case MapandbookpageRoute:
      return _getPageRoute(const MapAndBookPage());
    case PendingscrnRoute:
      return _getPageRoute(const pending_scrn());
    case UpcomingscrnRoute:
      return _getPageRoute(const UpComingsrn());
    case CompletedRoute:
      return _getPageRoute(const Completedscrn());
    case ParishmainhomeRoute:
      return _getPageRoute(const ParishMainHomePage());
    // case ReqprayerpageRoute:
    //   return _getPageRoute(const ReqPrayer_scrn());
    // case Payment_scrnRoute:
    //   return _getPageRoute(const Payment_scrn());
    // case UcompletedRoute:
    //   return _getPageRoute(const UCompletedscrn());
    // case UbookingpageRoute:
    // return _getPageRoute(const UBookingPage());
    // case SummaryMonitorRoute:
    //   return _getPageRoute(const SummaryMonitorPage());
    // case CurrentTaskRoute:
    //   return _getPageRoute(const CurrentTaskMonitor());
    // case ProjectAssignedEmployeeRoute:
    //   return _getPageRoute(const AssignedEmployeeProjectPage());
    // case AccountManagementRoute:
    //   return _getPageRoute(const AccountManagementPage());

    default:
      return _getPageRoute(const SplashScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
