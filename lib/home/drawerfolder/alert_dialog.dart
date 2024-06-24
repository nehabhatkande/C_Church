import 'package:cchurch/loginscreen.dart';
import 'package:cchurch/splashscrn.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Logout',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text('Are you sure you want to logout?'),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SplashScreen()));
                },
              ),
              TextButton(
                child: Text('Logout'),
                onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutDialog();
    },
  );
}
