import 'package:flutter/material.dart';

class HourlyBreakdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Hourly Breakdown Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hourly Breakdown Page Demo Text'),
            ElevatedButton(
              child: Text('Return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      )
    );
  }
}
