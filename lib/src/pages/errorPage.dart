import 'package:flutter/material.dart';

class Errorpage extends StatefulWidget {
  Errorpage({Key key}) : super(key: key);

  @override
  State<Errorpage> createState() => _ErrorpageState();
}

class _ErrorpageState extends State<Errorpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bug_report_outlined,
              size: 40,
              color: Colors.red[400],
            ),
            Divider(),
            Text('Sorry, Something Went Wrong',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey)),
            Divider(),
            TextButton(
              child: Text('Go to Home'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/Pages', (Route<dynamic> route) => false);
              },
            )
          ],
        ))));
  }
}
